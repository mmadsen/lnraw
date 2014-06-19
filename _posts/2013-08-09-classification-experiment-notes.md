---
layout: post
title: Classification Experiment Notes
tags: [cultural transmission, classification, coarse graining, simulation, ctpy, dissertation, experiments, experiment-classification]
categories: 
- project:coarse grained model
- model:ctpy
- experiment:experiment-classification
---
### Setup and Raw Simulations ###

**8/9/13** -- _Setup and Simulations_

Completed the code for classification experiments, at least to the point that an analysis script can run through classifications without parallelization and identify `individual_samples` to their classes given each classification in the database.  All of this is tagged "v1.0" in github, and was pulled to an EC2 `m3.xlarge` instance to do the raw simulation output.  

Raw simulations were done by using `neutral-kn-sweep.py`.  This took about 5 hours, costing about 5 dollars (for a total of 8 so far this month), and filled about 13GB given the current configuration of parameter space and sampling interval of 100 generations (for 10K generations after stationarity).  

Am working on expanding and reattaching the EBS volume with the MongoDB database, so I can do the subsampling, which ought to balloon the database by a factor of maybe 10x?  Will finish that tomorrow, delete the old snapshots and volumes, and run the subsampling script overnight, with the goal to be running the classification script while traveling.  Then I can shut everything down and analyze when I get back from the trip.  Might try to move the compressed DB back locally at that point, but will need to do it a the office on a fast connection.  

**8/10/13** -- _Subsampling and Start of Classification Identification_

Cleaned up my instances and resized the EBS volume to have 200GB to work with.  This probably will be enough, but we'll see.  I ran the subsampling program and the raw data collection grew to about 19GB.  I started the classification script, which runs each classification serially, and it's going strong.  I expect it to generate about 42MM individual documents by the time it's done, and that could be a day or two.  

**8/11/13** -- _Second Resizing_

Overnight, the classification script generated about 12MM observations, and about 50GB in database, which means that database is going to overflow the EBS volume and stop.  So I killed the process, nuked the postclassification database, and stopped the instance.  I'm starting a second resize now.  

Finishing resizing the new volume and snapshot, restarted classification at 10:40am on 8/11.  


### Analysis ###


Processing for analysis is going to involve some steps, given 42MM samples.  

1.  Restart EC2 instance and get copy of param space, ensure we record it here (if different than the basic one in github).
2.  Copy the database somewhere that I can analyze it.  Might have to live on the external TB drive just ordered, if I want to work on it via the laptop.  

#### Preprocessing ####

1.  The `individual_samples_classified` collection needs some basic post-processed statistics, like richness, and class count/freq. These operations are on a per-database-entry basis, and thus can be maximally parallelized via some architecture - Hadoop, Storm, etc.  
2. Data frames then need to be created which have parameters for both simulation run and classification.  These should be `pandas` data frames, so we can easily move them to R.  






#### Statistics ####

$\mathrm{IQV} = (\frac{k}{k-1}) (1 - \sum_{i=1}^k p_i^2 )$


