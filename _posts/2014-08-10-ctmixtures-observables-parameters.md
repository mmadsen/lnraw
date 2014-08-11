---
layout: post
title: Observables and Parameters in CTMixtures
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Parameters of the Model ###

Each model instance is parameterized by the following inputs:

* A set of copying rules, each applying to a fraction of the population
* Population size
* Innovation rate (in population-level "theta" rates, not per individual "mu" rates)[^1]
* Number of features/dimensions in an individual's cultural repertoire
* Number of initial traits per feature from which random assignment is made to begin simulation
* Strength of conformism or anticonformism bias, if these copying rules are used
* Interval of time (in units of popsize, or "Wright Fisher generations") over which Kandler-Shennan trait survival analysis is tracked.  
* Set of sample sizes for sampled observations in the population
* Set of durations over which time averaged and sampled observations are made
* A population structure, over which individuals are arrayed and over which copying events occur (e.g., well-mixed, or a square lattice)
* A dynamics model (e.g., Moran approximation to continuous time, Wright Fisher discrete generations)

For the CTMixtures experiment, some of these (e.g., dynamics model and the list of sample sizes and TA durations used) will be held constant, while others will vary across model instances and simulation runs (e.g., innovation rate)


### Observable Variables ###

The CTMixtures software records the following measurements, across three observational methods.  The methods are:

1.  Whole population enumeration at a point in time
1.  Sample statistics taken at a point in time, taken across configured sample sizes
1.  Sample statistics taken from a set of time averaged durations, across sample sizes

For each of these data collection methods, the following are measured:

* Trait counts & frequencies for each feature/dimension
* Intersected traits from each dimension/feature ("configurations") - counts/frequencies
* Slatkin exact tests for per-feature trait counts, and configuration counts
* Shannon entropy and IQV evenness for per-feature trait frequencies and configurations
* Trait richness for per-feature trait counts, and configuration richness
* Kandler-Shennan surviving trait counts over interval

Given a set of 3 time averaging durations, and 3 sample sizes per model (for example), the set of 6 classes of observables yields 54 classes of observables for each model instance, some of which may be repeated on a per-feature/dimension basis.  

This set of observables are available for classification or regression techniques to see if models are identifiable from observables alone.  

### Notes ###

[^1]:  The idea here is to standarize the gross "amount" of innovation across population sizes for statistical comparison of the observables.  The simulation system calculates a per-individual, per-locus rate of innovations from this parameter value using population size and the number of features/dimensions.  
