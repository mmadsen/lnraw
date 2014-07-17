---
layout: essay
title: Experiment Template for Reproducible Simulation Models
tags: [experiments, simulation, open science, reproducible science]
categories:
- essays
- simulation
- reproducible science
---

### What is an "Experiment Template"? ###

In an effort to render the analysis of simulation results more easily reproducible, I've been evolving a standard directory structure and various scripts for standardizing the way data are cleaned, imported, and analyzed.  In addition, the template includes a paper manuscript and directory for presentations.

My current template is [available on Github](https://github.com/mmadsen/experiment-template).  

### Why Use a Template? ###

An experiment template like this serves a couple of purposes:

1.  Allowing anyone a way to repeat a data analysis easily
1.  Allowing ME a way to repeat an analysis, while making controlled changes (e.g., while writing a paper, I might need a different visualization or additional statistics)
1.	The template also allows me to carry over tools and best practices between experiments, and not reinvent the wheel.  My work becomes more efficient as the tools and scripts accumulate 


### How I Use the Template ###

To start a new experiment, I do the following:

1.  Clone the Github repository into a location where you want to do your work
1.  Change the name of the directory to whatever you like (e.g., "experiment1")
1.  Inside the new experiment directory, delete the `.git` subdirectory to cut the link to the original Github repository:  `rm -rf .git`
1.  Add the experiment directory to whatever version control system you're using.  If you're staying with Git, you'd just do `git init`.

At this point, I can start working.  I do these steps **after** I've written and tested the simulation software I'm going to be using, but **before** I've done any of the simulation runs for the experiment.  

An experiment then proceeds roughly like this (possibly with some returns through various steps):

1.  Build configurations for the simulation runs I want to do, putting these in the `simulations` directory.  In this directory are also an evolving set of scripts for starting EC2 instances, and checking the progress of simulation runs running on these instances.
1.  Perform simulation runs
1.  Export raw data from all the simulation runs.  Copy the raw data to suitable file formats (e.g., CSV) in the `analysis/data` directory, if you can [^1].  If not, copy the raw data to another local directory, outside the experiment, and then archive it somewhere accessible, like an S3 bucket, in order to provide open access.  
1.  Perform data cleaning and preparation, putting all of these steps into scripts stored in `analysis`.  If you do these steps in R, there is already a script in this directory you can extend or change.  I often do some steps in Python, some in Apache Pig (particularly if I'm summarizing and merging many large raw data files), and then I do the last preparation steps in R to produce a "clean" data set for analysis.  
1.  Perform data analysis.  I tend to do all of my analyses as RMarkdown documents, so that I have analysis and explanation of the analysis in a single file.  Graphics are saved to PDF files in the `analysis/figure` directory.  

I should note that the `analysis.Rmd` file that contains R analyses is **not** a paper.  The text portions of this file are notes about the analysis and my thinking.  

At points in the analysis, I might need to test an idea or generate some ideas about how to approach something.  Sometimes I might noodle around in iPython notebooks, or Mathematica.  If these activities are not part of the analysis chain itself, I put such materials in the `explorations` directory.  Sometimes this directory has nothing in it.  Sometimes it's full of little Mathematica notebooks or R files.  An example of something that might go in this directory are calculations for how many simulation runs I might need to do, or calculations for how large a graph or tree I can work with before the simulation runs out of memory.  These examples are crucial to the experiment, but not the chain of calculations that turns data into final statistics and graphs.  But it's useful and important to keep track of them, so they stay with the data and analysis and are version controlled.  

Once I'm ready to write up the experiment, I start working on an outline for the paper in the `outline` directory, and the paper itself in the `paper` directory.


### Making It Your Own ###

In the `paper` directory, my name and contact information exists in the `xelatex-template.tex` file.  If you're going to use the existing paper system, turning RMarkdown into a PDF, you should edit that file and change the title, author, and contact information.  Otherwise you don't need to touch that file.  There is also my name and information in the `outline` directory in `outline.tex`.  



[^1]:  Github doesn't allow files bigger than 100MB, or repositories larger than 1GB.  Raw data from many simulation runs are often larger than this.  

### References Cited ###

