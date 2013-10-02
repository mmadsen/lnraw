---
layout: essay
title: Making the Case for "Medium" Data
tags: [analytics, programming, R, python, Hadoop, big data, medium data]
category: essays 
---
Chris Stucchio's recent post ["Don't use Hadoop - your data isn't that big"](http://www.chrisstucchio.com/blog/2013/hadoop_hatred.html) is a valuable read for many of us in the sciences, whose data are "large," but not "big data" in the current industry buzzword sense of the term.  In the sciences, astronomers doing automated sky sweeps have big data.  The physicists are CERN have big data.  Mostly, the rest of us have small to medium data.  I'd like to make a case that there are methods and best practices for the analysis of **medium** scale data that have been largely ignored until now.  And that folks doing computational studies in any discipline need to think about how to set up an analysis of medium-scale data such that it's replicable and accurate.  

### Defining Medium Data ###

Small data, of course, are any data set where it doesn't matter what tools you use -- any operation you choose finishes about the time your finger comes off the "Enter" key.  Or within a couple of seconds, tops.  Small data are those that fit in an Excel worksheet (although since V2010 or so, a sheet can have 1.048 million rows instead of the old limits of 65K or so, so arguably you can trend into "medium" data with Excel now as well) [^1].   

Medium data are those where you can't easily perform routine operations:

* Hand edit the data to clean them up, even in a good programmer's text editor
* Commit the raw data files to Github along with your analysis code because the files balloon your repository and are difficult for people to download
* Do simple manipulations like sorting, merging, adding or deleting columns in a GUI tool (e.g., Excel) 
 
Medium data are also: 

* Small enough that scripts or programs can do meaningful processing of the data in a reasonsable time frame (minutes or occasionally hours)
* Small enough that R or pandas/numpy in Python can load your data into memory [^2]

If your data are larger than this, you do need a parallelized or cluster solution.  Perhaps that solution is Hadoop and MapReduce, perhaps it's not.  Not every problem is easily expressed in the MapReduce paradigm.  


### A Medium Data Example ###

I'm working with a dataset right now, from my experiments on [observing cultural transmission through classifications](http://localhost:4000/tag/classification.html), that exemplify "medium data."  The primary data in MongoDB are 70GB, and when exported to 2 CSV files for further processing take up 2GB and 16MB, respectively.  (MongoDB has been a terrific choice for primary data storage in my simulations, but hoo boy, it ain't space efficient...).  

The data set I'm describing here has 9.504 million rows, with 24 columns aross the two files.  The "big" file has many replicates at the same "parameters," and requires aggregation (by calculating mean and standard deviation).  The small file is a set of measurements which apply to specific parameter combinations in the big file, and thus can be combined with an "inner join."  The end product of pre-processing and data cleaning, therefore, is a single file, with the 9.504 million rows aggregated to form 95,040 rows, with duplicate columns removed after joining.  

There are really two approaches to preprocessing these data:

1.  Load the files into R data frames, and use `plyr` and associated packages to join and aggregate the data.  
2.  Write a script or scripts to perform the join, aggregation, and de-duplication.  

At this scale, both choices are workable.  I've done it both ways.  But there are circumstances where the second approach is superior for this sort of cleaning/preprocessing (you're still going to do your actual analysis in R, or at least a combination of R and Python):

* You will repeat this analysis across many data sets
* Your data size will grow over time
* The analysis will be part of a real-time interface for users

None of these circumstances _necessarily_ rules out the use of R.  You can parallelize many things in R, and in this case by combining `plyr` with `doMC` (or Hadley's upcoming directly parallelized version of `plyr`).  And you can easily use R from the command line or within a long-running server process.  But you won't be doing it interactively -- you'll be implementing the second approach using R as your scripting language (likely using `Rscript`).  

The early stages of my post-processing pipeline are written in Python, while the second half are written in Apache Pig.  In this particular case, the first steps in processing involve reading raw simulation output from the database, and then performing transformations (such as identifying trait values to corresponding coarse-grained classification cells).  The second half of the post-processing is essentially all record processing -- joining independent data blobs to each other, removing duplicate columns in the result, and then aggregating rows.  This is all standard "SQL-like stuff" and Pig is perfect for such operations (while setting us up to scale from small to medium to big data sets in the process).  

[Apache Pig](http://pig.apache.org/) is a data analysis platform which sits on top of the Hadoop MapReduce platform, while being capable of running on a single node.  This gives your Pig scripts huge potential scalability, coupled with a dead-simple language and operations for processing data.  

### Best Practices ###

In working with "medium" data, I've started developing some habits.  Perhaps these habits are not full "best practices" yet, but I'll share them anyway.

#### Build and Test in Small Pieces ####

At the moment, I have 8 separate small scripts which take original simulation run data in half a dozen database "tables" (or "collections" in MongoDB terms), and lead to a final unified CSV file capable of import to R for analysis.  Each script does _one_ thing, and saves its output to an output file (or partfiles, in the case of Pig).  

This is the scripting equivalent of "separation of concerns" in programming, and it allows us to verify the step by step correctness of our processing steps, and isolate the problem when something goes wrong. It also allows us to easily construct simple tests for each stage of the process, to verify that correctness.

#### What?  I Don't Need Tests for Data Cleaning ####

By now, you're probably convinced of the need for unit and functional tests for any complex piece of code, especially if you expect other people to use that code, or trust its output.  If you're not convinced of this fact, I recommend Kent Beck's [original paper on the subject of test frameworks](http://www.xprogramming.com/testfram.htm). 

But very few people seem to test the little operations we use for "munging" data into shape for analysis.  We can see, right on the screen, that our data look as we expect them to!  That was possibly true when your data set fit into a single Excel worksheet, and you could visually verify that it had the right format for columns, the correct number of rows, and so on.  When you joined two data files together, it was usually possible to see whether they "aligned" correctly, by eye.  

Can you do that by inspection with 1GB of data?  10GB?  I can't, and neither can you.  Instead, you need tests.  Tests can be simple -- one test I always make between steps is **verifying the expected number of rows of output**.  If you are processing 1M rows (and 6 columns) through a script which does a calculation and adds the result as a column, you should get 1M rows x 7 columns in your output file.  

This is **particularly** important for processing that performs joins or aggregation.  Let's say you're aggregating replicate measurements together.  For each column that had replicated measurements, you know how many replicates.  Multiply these together to find the total "replication factor."  If you divide the total number of rows by this replication factor, this is the number of rows of aggregated output that should be produced.  Knowing this, you can check whether your join script is doing the correct operations.  

Other simple tests include bounds checking on derived values.  In one processing step, I reduce a large number of individual samples to various diversity indices.  Several of the indices are constrained to lie between 0.0 and 1.0.  This simple sanity check led to finding at least one bug in my database queries, incidentally. 

#### Script the Scripts ####

Breaking your processing chain into small scripts, each performing a task and capable of verification, raises the danger that you'll execute them in the wrong order.  This may or may not lead to overt errors, but if not, a variety of subtle errors can creep into your data.  Thus, I always "script the scripts" -- keep a simple shell script which executes each processing step in order.  

While I'm writing the scripts and testing, I usually execute each one manually (often many times).  But when I actually produce the data set for analysis, I *always* use the overall "driver" script to ensure that all of the processing steps happen in the right order.  


### References Cited ###




[^1]:  This is not an endorsement of Excel for data analysis.  In fact, you **SHOULD NOT** use Excel for data analysis, at least for anything more complex than some sums and averages.  The statistics literature is rife with examples of Excel's terrible statistics function implementations [@mccullough2008accuracy][(Download the [PDF] here)](http://www.pages.drexel.edu/~bdm25/excel2007.pdf).  McCullough has documented Excel's statistical failures through successive releases, and notes that flaws publicized over 15 years ago still persist (at least in Excel 2007).  Nor are these minor round-off errors -- examples abound of regression analyses that return the wrong sign for a regression coefficient or correlation coefficient, and so on.  If you care about your results, **DO NOT** use Microsoft Excel.   

[^2]:  This assumes that you have maxed out your laptop's RAM (Mine have 16GB, for precisely this reason) or have upgraded your desktop.  If you have large data sets, and are operating on 2 or 4GB of RAM, you should seriously consider upgrading.  


