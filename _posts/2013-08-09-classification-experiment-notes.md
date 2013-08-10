---
layout: post
title: Classification Experiment Notes
tags: [cultural transmission, classification, coarse graining, simulation, ctpy, dissertation, experiments]
category: coarse grained model project
---
### Setup and Raw Simulations ###

**8/9/13**  Completed the code for classification experiments, at least to the point that an analysis script can run through classifications without parallelization and identify `individual_samples` to their classes given each classification in the database.  All of this is tagged "v1.0" in github, and was pulled to an EC2 `m3.extra-large` instance to do the raw simulation output.  This took about 5 hours, costs still TBD, and filled about 13GB given the current configuration of parameter space and sampling interval of 100 generations (for 10K generations after stationarity).  

Am working on expanding and reattaching the EBS volume with the MongoDB database, so I can do the subsampling, which ought to balloon the database by a factor of maybe 10x?  Will finish that tomorrow, delete the old snapshots and volumes, and run the subsampling script overnight, with the goal to be running the classification script while traveling.  Then I can shut everything down and analyze when I get back from the trip.  Might try to move the compressed DB back locally at that point, but will need to do it a the office on a fast connection.  




