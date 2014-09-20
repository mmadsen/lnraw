---
layout: post
title: CTMixtures Equifinality Analysis - Initial Ideas
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Trial Run ###

I'm not finished with the data export program yet, working out how to flatten multiple loci and other list/nested data structures.  This is particularly important since some elements are measured only once (e.g., configurations or classes) while others are measured on a per-locus basis.  At the same time, there's an element of feature selection and engineering occurring, which is happening via a trial random forest classification.  

The population census data are fairly easy and finite, so I've already got them exported with an initial cut at the program, with the following predictors for the four model class labels:

* Slatkin exact test for the configuration or class counts in the population census
* Number of configurations in the population at sample time
* Per-locus Shannon entropy of trait frequencies
* Per-locus IQV diversity of trait frequencies
* Per-locus richness of traits
* Kandler-Shennan traits surviving after 50 generations

A very quick random forest fit on 80% of the data as training data (with typical classification values) shows that there's a lot of error correctly classifying data points, and thus good hints of equifinality.  

```
Call:
 randomForest(formula = factor(model_class_label) ~ ., data = train,      ntree = 1000, nodesize = 1, mtry = 3) 
               Type of random forest: classification
                     Number of trees: 1000
No. of variables tried at each split: 3

        OOB estimate of  error rate: 48.24%
Confusion matrix:
             allneutral mixantidom mixconfdom mixconfequal class.error
allneutral        27560       1515       1986         1014   0.1407638
mixantidom         1659      14881       6724         8700   0.5344450
mixconfdom         2006       7925      13822         8173   0.5670613
mixconfequal       1665      10860       9526         9984   0.6883409
```

Prediction error on the remaining 20% of the data is 0.516.  But there's an interesting pattern here, and some issues with the data export.  

First, it doesn't seem nearly as hard to tell neutral models from biased models, as it is to tell different bias models apart, as you'd expect.  Perhaps this should be the expectation given synchronic population census.  We'll see how this plays out in synchronic sampled data, and of course TA and sampled data.  But I should also do a binary classification, lumping the bias models together, and simply predicting neutral vs. bias.  

But second, some of the values are repeated in each row, since a row represents a locus, not a simulation run.  I should do further feature engineering and have only one row per simulation run in the data export, and use variables like min/max/median richness, entropy, etc.  This will apply to all multilocus data. 

### Sampled and TA Export ###

In the case of the sampled and TA'd data, I'll output single rows for each combination of simulation run, sample size, and TA duration, using summary statistics for multilocus elements, and the actual values for configuration/class data.  

Each sample size and TA duration will then be analyzed against its counterparts, not mixed together.  

