---
layout: post
title: CTMixtures Analysis -- RF to GBM and Next Steps
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories:
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### From Random Forests to Gradient Boosted Machines ###

I didn't find any problems with random forests, but the time needed to do a properly tuned model fit using `caret` and a reasonable grid of `mtry` values, on 100K, 200K, or 800K data points pretty prohibitive, especially if you're doing repeated CV to find the best tuned model fit on the training set.  A model fit and tuning was taking 24 to 36 hours, even when parallelized on 4 cores.  Since I'm doing many analyses, the options seemed to boil down to (1) run every analysis on large EC2 instances with 16 or 32 cores, hoping to shave down the analytic time to something reasonable, or (2) find a classifier with high accuracy but a shorter runtime.  

Boosted classification trees are always among the top classifier algorithms, and in Friedman's gradient boosting version, achieve extremely high accuracy while mostly avoiding overfitting, and providing measures of predictor importance.  Gradient boosted machines, like random forests, break the classic tradeoff between bias and variance, allowing us (within limits) to optimize both [@AlexeyNatekin:2013ew; @hastie2009elements].  They do so by combining several approaches to randomization and aggregation:

1.  Applying "shrinkage" to each boosting iteration to dampen the effect of each gradient step, forcing slow convergence of the model to an averaged estimate of the class for each data point.
2.  Out-of-bag testing internal to the algorithm.
3.  Sequential reweighting of data points in determining classification trees, giving misclassified points greater weight in determining the tree splits.   

Using the superb `caret` package from Max Kuhn allows an easy switch between classifiers without changing most of the analysis code, so the change was simple.  By default, the `gbm` package through `caret` uses bootstrap resampling with a small number of boosting iterations, which is sufficient for seeing how the package works, but not a real analysis.  Currently, I am using the following tuning parameters:

* interaction depth:  $[2, 4, 6, 8, 10, 12]$
* number of trees:  $[25, 50, 75, 100, 125, 150, 175, 200, 225, 250]$
* shrinkage:  0.05
* tuning method:  repeated 10-fold cross validation, 5 repeats

In my initial tests, plots of CV accuracy tend to plateau after 100 iterations, with larger interaction depth, so technically I don't really need to include smaller values in the tuning parameters.  But the `gbm + caret` package optimizes by fitting the largest models, can derive the smaller ones from the full model without recalculation, so the execution time is largely controlled by the largest values of the tuning parameters and the number of repeated CV folds and repeats.  

In most cases, a model fit to 100K data points, with 20% held out as a strict test set, takes between 80 and 90 minutes, with 4 cores on a Retina MBP.  That's acceptable, although I've put some effort into ensuring that all of my analyses can be run on the command line via a Makefile, automatically storing their results in `.Rdata` files for later interpretation and use.  That way, I can do final runs on a server instance.  

The quality of the classifications is comparable to, and even slightly higher than, the random forest classifications of these data.  The difference is very small and likely not significant, so for present purposes, I would consider GBM and RF to be equivalent and acceptable methods for attacking equifinality issues between cultural transmission models.  


### References Cited ###

