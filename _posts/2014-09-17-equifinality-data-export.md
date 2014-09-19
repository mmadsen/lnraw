---
layout: post
title: CTMixtures Equifinality Data Export
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Data Consolidation ###

At the conclusion of the simulation runs, each of the 8 compute nodes had a separate MongoDB database with identically named databases and collections, but separate rows of data.

Each MongoDB instance was stopped, and the contents of the `/sim/data` directory containing the raw MongoDB files was archived and compressed, and copied to a local machine so that the cluster could be terminated (stopping the cost of running it).  

On a local database, a new database called `equifinality-1-merged` was created, and each node's database was copied into it via a pair of `mongoexport` and `mongoimport` calls.  The original MongoDB binary files, in `tar.gz` format, are archived on S3, as will a merged JSON export format.  This is handy in addition to CSV files so that database operations can be used to operate on the dataset, which in datasets much larger than this is preferable to doing it within R or Python on a row-wise basis.  


### Data Export ###

The `ctmixtures v2.3` simulation code records one data record in a MongoDB database for each simulation run.  Since that record contains nested data structures corresponding to different sample sizes and time averaging durations, this note records how the record is unpacked into raw data files which archive the results of simulation, and form the basis of further analysis.  

The script `analytics/ctmixtures-export-data.py` is used against the MongoDB instance on each running compute cluster node, to produce CSV files, which are then centralized and combined to form the full raw data set from a simulation experiment.  The program generates four raw data files:

1.  general simulation information: random seeds, configuring classes, all model parameters
1.  population census statistics, model class label, simulation id
1.  sampled statistics, model class label, simulation id
1.  time averaged and sampled statistics, model class label, simulation id

In these data export files, I am not exporting lists of trait counts or frequencies.  These will remain in the original database for future queries and analysis, but are not used in the equifinality analysis.  



### Data Export Process ###

TBD - exact StarCluster steps for performing the data export