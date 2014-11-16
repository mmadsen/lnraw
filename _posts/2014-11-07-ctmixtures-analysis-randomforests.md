---
layout: post
title: CTMixtures Analysis -- Equifinality 3 Notes
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories:
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Equifinality-3 ###

Given the results of [calibration experiments](/project:coarse%20grained%20model/model:ctmixtures/experiment:experiment-ctmixtures/2014/10/06/ctmixtures-calibration-part2.html), I ran 100,000 simulations (25K for each of four models), on a StarCluster of 4 instances, each with 16 vCPUs, for a total of 64 cores.  The time estimate was low by a bit, and the experimental run cost almost $500 instead of $300, which means I need better cost estimation.  

The raw data for `equifinality-3` are stored on [Amazon S3, here](https://madsen-dissertation.s3.amazonaws.com/), and the analysis, scripts, and paper on [Github, here](https://github.com/mmadsen/experiment-ctmixtures).

Currently, I've exported population census and sampled data, and am working on exporting the time averaged and sampled data correctly.  

### Model Analysis and Tuning ###

I am still convinced that random forest classifiers are the best method of proceeding to detect equifinality given a set of summary statistics.  For `equifinality-3`, I decided that it wasn't enough to eyeball the tuning parameters for the random forest algorith, however.  Using the superb `caret` package in R, I proceed as follows:

1.  Split the data set into 80% train, 20% test data, with balanced numbers from each model class.
2.  Train the random forest classifier over the training set, using 1000 trees and different values of `mtry`.  
3.  Perform the training step #2 using 10-fold CV and 10 repeated CV trials, and using ROC and Kappa values, select the model which has the lowest error on the CV hold-out folds over the 100 trials.  
4.  Using this final tuned model, evaluate the classifier performance on the 20% test set, which has not been involved in any training and tuning.  

Evaluation of the final model constitutes the equifinality evaluation itself, and I'm using the following statistics to perform the analysis:

1.  Relationship between ROC curves for each of the sets of CT model summary statistics (population census, sampled, TA/sampled).  This includes the area under the ROC curve (AUC).  
2.  Specificity and sensitivity values (true positive and false positive rates per class).  
3.  Patterns in the confusion matrices (e.g., are neutral models often mistaken for bias, but not the other way around?)

I should note that the training and tuning process is extremely time consuming given sample sizes this large, with 10/10 repeated cross-validation.  Each set of summary statistics (census and sampled) took between 8 and 10 hours, with parallelization across 4 cores (and the sampled data is split into sample size chunks of 100K observations each, so it's about 10 hours per sample size chunk).  

### Separation or Mixing of Sample Size/TA Intervals ###

Most of the time, of course, real-world samples will come from a variety of population sizes, sample sizes, time averaging durations, etc.  But the most rigorous test for **irreducible** equifinalities occurs when we hold all of the parameters constant and examine our ability to construct a classifier which correctly identifies cases stemming from different transmission models.  

Thus, in one set of analyses, I separate data with different sample sizes (and, if relevant, time averaging durations) and analyze classifier performance separately.  Since all 8 combinations of sample size and TA duration are taken from each simulation run during data recording, there are actually 800,000 rows of data in the time averaged and sampled data set, giving a full 100,000 data points for each combination, retaining comparability of the analysis when we try to compare classifier performance from the population census data against sampled against time averaged & sampled data.  

We can also evaluate the classifier performance on mixed combinations of sample size and time averaging duration, by not taking subsets of the data set, and training across the entire data set.  We might do a stratified random downsample in order to make sample sizes comparable between this analysis and the population and sampled data sets.  

### References Cited ###

