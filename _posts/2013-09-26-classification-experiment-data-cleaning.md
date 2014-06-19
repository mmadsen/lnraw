---

layout: post
title: Classification Experiment - Data Reduction and Cleaning
tags: [cultural transmission, classification, coarse graining, simulation, ctpy, dissertation, experiments, experiment-classification]
categories: 
- project:coarse grained model
- model:ctpy
- experiment:experiment-classification

---

### Data Description ###
The classification experiment simulation runs encompassed 48 combinations of innovation rates and population sizes, which were performed in 10 replicates per combination, for the Wright-Fisher infinite-alleles (WFIA) model of cultural transmission without bias or natural selection.  

Each combination was additionally run at a variety of trait-space dimensionalities, and sampled at a variety of sample sizes.  Once each simulation run had achieved stationarity, 10 samples were taken from each replicate at 100 generation intervals.  

The full parameter space used to run the experiment is as follows:

| Simulation Parameter                   | Value or Values                                   |
|:---------------------------------------|:--------------------------------------------------|
|    Trait and classification dimensionalities   |   2, 3, 4, 6, 8  | 
|    Classification coarseness levels (modes per dimension)   |   2, 3, 4, 8, 16, 32  | 
|    Number of traits per dimension for initializing population   |   10  | 
|    Innovation rates   |   0.0001, 0.00025, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.025  | 
|    Replicate random classifications per coarseness level   |   10  | 
|    Num samples taken after stationarity, per run   |   10000  | 
|    Population sizes   |   500, 1000, 2500, 5000  | 
|    Replicate simulation runs at each parameter combination   |   1000  | 
|    Sample sizes taken at each sampling interval   |   25, 50, 100, 200  | 
|    Interval in generations for samples after stationarity   |   1  | 
|    Length of simulation run after stationarity   |   10000  | 



These primary data comprise 144,000 samples of the following metrics, calculated upon the raw trait counts:

* Trait richness per dimension
* Shannon entropy per dimension
* IQV per dimension
* Mean trait richness over all dimensions
* Shannon entropy over dimensions
* IQV over dimensions
* Slatkin-Ewens-Watterson test of neutrality over all dimensions

The 144K samples were then "observed" through 66 classifications, with the classification dimensionality equal to the trait space dimensionality (there were, in total, 330 classifications, 66 for each of the dimensionality levels).  The classifications were of two types:  EVEN partitions of dimensions into modes (with six levels of coarseness), and RANDOM partitions of dimensions into modes (with the same six levels of coarseness).  For random partitions, 10 different random partitions were made for each level of coarseness.  This yields 66 classifications for each level of dimensionality.  Neutrality tests were also performed for class counts as a whole.  

Observing the 144,000 samples of the raw trait space through 66 classifications yielded 9,504,000 samples of class statistics in the "postclassification" sample.   


### Data Projection ###

Prior to analysis in R, the data samples went through several cleaning and reduction steps, outlined here.  

Raw simulation samples are stored in MongoDB by the CTPy/simuPOP simulation code, and the initial post-processing is also done in Python by projecting MongoDB tables into new data collections.  These steps include:

1.  Projecting the raw simulation runs to encompass the full set of dimensionalities and sample sizes. 
2.  Calculating trait-space statistics from the samples of individual agents, given the cartesian product of dimensionalities and sample sizes.
3.  Identifying raw samples of individuals to each of the 66 classifications, and recording classification level statistics for each time slice (per-generation statistics).
4.  Calculating any statistics that require looking at temporal spans or sample paths (planned but not currently implements).  

The output of these sampling and classification operations are stored in a single MongoDB collection for the experiment.  A Python script is then used to export CSV data for further processing.  This script selects a subset of fields from each table, and uses the `mongoexport` program to produce the CSV files, for speed.  

These exports are copied to the `rawdata` directory of the [experiment and analysis](https://github.com/mmadsen/experiment-classification) repository, for data cleaning and reduction.  

### Data Reduction ###

Once exported from MongoDB, I use a set of Apache Pig scripts to merge data files together, remove duplicate columns, and perform aggregation across replicates in the dataset.  The end result of these processing steps is a single CSV file with columns for each key value in the data set, and mean/sd statistics for each observable value (e.g., class or trait entropy, richness).  

The processing steps and scripts are all contained in the Github repository for the [experiment and analysis](https://github.com/mmadsen/experiment-classification).  The `README.md` file in that repository contains detailed instructions on how to replicate the data cleaning and reduction steps using the supplied scripts.  

The basic replication factor in this experiment is 100 replicates per classified sample -- 10 simuPOP replicate populations, and 10 samples per sample path.  So the final dataset for analysis should contain 95,040 samples.  For each metric, the `average-replicates.pig` script returns a data set with 95,040 rows, with mean and standard deviations for each of the classified and raw trait metrics gathered above.  

The unaveraged data are retained for analyses where we may want them.  This data set is the aggregated output of the script `clean-numerics.pig`.  

Once completed, the CSV files resulting from the Pig scripts are copied to the `data` directory of the experiment repository, as the files:

* `classification-experiment-neutral-dataset-fullrows.csv`
* `classification-experiment-neutral-dataset-grouped.csv`

Once imported to R via the `R/load-datasets.r` script, the CSV files will not be imported unless the binary data objects (for speed) are deleted.  Thus, hereafter we operate upon the objects:

* `classification-full.rda`
* `classification-grouped.rda`

**IMPORTANT** The full dataset, either in CSV or RDA format, is too big to include in the Github repository, and too large to upload to Figshare.  As the `README.md` in the experiment repository notes, if you do not want to regenerate these files by running the simulations yourself (which can take awhile, especially for the post-simulation classification step), contact me and we can arrange something for getting you copies of the raw data files (approx. 2GB file download).  

