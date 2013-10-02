---

layout: post
title: Classification Experiment - Data Reduction and Cleaning
tags: [cultural transmission, classification, coarse graining, simulation, ctpy, dissertation, experiments]
category: coarse grained model project

---

### Data Description ###
The classification experiment simulation runs encompassed 48 combinations of innovation rates and population sizes, which were performed in 10 replicates per combination, for the Wright-Fisher infinite-alleles (WFIA) model of cultural transmission without bias or natural selection.  

Each combination was additionally run at a variety of trait-space dimensionalities, and sampled at a variety of sample sizes.  Once each simulation run had achieved stationarity, 10 samples were taken from each replicate at 100 generation intervals.  

These primary data comprise 144,000 samples of the following metrics, calculated upon the raw trait counts:

* Trait richness per dimension
* Shannon entropy per dimension
* IQV per dimension
* Mean trait richness over all dimensions
* Shannon entropy over dimensions
* IQV over dimensions

The 144K samples were then "observed" through 66 classifications, with the classification dimensionality equal to the trait space dimensionality (there were, in total, 330 classifications, 66 for each of the dimensionality levels).  The classifications were of two types:  EVEN partitions of dimensions into modes (with six levels of coarseness), and RANDOM partitions of dimensions into modes (with the same six levels of coarseness).  For random partitions, 10 different random partitions were made for each level of coarseness.  This yields 66 classifications for each level of dimensionality. 

Observing the 144,000 samples of the raw trait space through 66 classifications yielded 9,504,000 samples of class statistics in the "postclassification" sample.   

### Data Projection ###

Prior to analysis in R, the data samples went through several cleaning and reduction steps, outlined here.  

Raw simulation samples are stored in MongoDB by the CTPy/simuPOP simulation code, and the initial post-processing is also done in Python by projecting MongoDB tables into new data collections.  These steps include:

1.  Projecting the raw simulation runs to encompass the full set of dimensionalities and sample sizes. 
2.  Calculating trait-space statistics from the samples of individual agents, given the cartesian product of dimensionalities and sample sizes.
3.  Identifying raw samples of individuals to each of the 66 classifications, and recording classification level statistics for each time slice (per-generation statistics).
4.  Calculating any statistics that require looking at temporal spans or sample paths (planned but not currently implements).  

The output of these sampling and classification operations are stored in a single MongoDB collection for the experiment.  A Python script is then used to export CSV data for further processing.  This script selects a subset of fields from each table, and uses the `mongoexport` program to produce the CSV files, for speed.  

### Data Reduction ###

Once exported from MongoDB, I use a set of Apache Pig scripts to merge data files together, remove duplicate columns, and perform aggregation across replicates in the dataset.  The end result of these processing steps is a single CSV file with columns for each key value in the data set, and mean/sd statistics for each observable value (e.g., class or trait entropy, richness).  

The basic replication factor in this experiment is 100 replicates per classified sample -- 10 simuPOP replicate populations, and 10 samples per sample path.  So the final dataset for analysis should contain 95,040 samples.  


