---
layout: post
title: CTMixtures Experiment Design
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Goals ###

The overall goal is to understand the degree to which samples of class or trait frequencies are identifiable to models, or conversely, the degree to which models which differ in the mode of CT or parameterizations are equifinal, especially given sample size and time averaging factors.  

### An Approach to Equifinality ###

A weak test of equifinality is to look at the empirical distribution of observable variables, and test their overlap across models and parameterizations.  This is an important measure of equifinality for situations where we have already published data, or no access to raw frequencies from which to calculate statistics.  

But the strongest examination of equifinality will come from treating model identification as a classification problem or GLM with multiple nominal outcomes.  This asks the question, how accurately can we predict the data generating process by a combination of observables used as predictors?  In general, equifinality is indicated by an inability to predict with confidence.  

In addition to allowing more sophisticated prediction models, we can use k-fold cross validation or simply separate training and test, to strongly estimate prediction accuracy.  

We can, for example, generate test data from the desired models (e.g., mixtures of copying rules) but with slightly different parameters for innovation or population size, to test prediction accuracy with a true out-of-sample test.  

### Is Identifiability Improved If We Know (Some) Parameters? ###

In general, the goal is to determine equifinality without reference to any unobservable parameters.  We rarely, in samples from real populations, have measurements (or even estimates) of population size, or innovation rates, or the prevalence of different modes of transmission in the population.  

But there may be certain situations where one or more parameters (but not, perhaps, all), are known for the population of interest.  For example, Jon Scholnick's data on New England gravestones has a fairly good enumeration of gravestone carvers during the period of interest.  In such a situation, we have at least an estimate of N for certain models (we may not know the population buying the gravestones, however).  In this situation, is identifiability improved if we can include population size as a predictor in our multi-logistic regression or classification procedure?  


### References Cited ###
