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

A weak test of equifinality is to look at the empirical distribution of observable variables, and test their overlap across models and parameterizations.  This is an important measure of equifinality for situations where we have already published data, or no access to raw frequencies from which to calculate statistics.  Some work along these lines already exists with neutrality tests in [@madsen2012ta;@premo2014cultural;@Porcic2014-ta].  

But the strongest examination of equifinality will come from treating model identification as a classification problem with multiple predictors.  Given all the observable statistics we can calculate or simulate from a given CT model, can we find any combination of the predictors that allows us to accurately predict the model class?  This allows us to include interactions between observables.  Even if these may not make sense in terms of the underlying diffusion theory, our job here is simply to find any accurate separation of the models.  

Analysis options include SVM or logistic regression for a problem setup where we want to distinguish between two different "models."  In general, equifinality will be indicated by an inability to separate different models, even in the training data, even with free combinations of any and all predictors.  

A good general experiment is to start with a two-class regression, and if we can accurately differentiate neutral versus heterogeneous models (as a group), then move on to distinguishing between specific heterogeneous models with multinomial LR or a GLM.  

We can also generate test data from the desired models (e.g., mixtures of copying rules) but with slightly different parameters for innovation or population size, to test prediction accuracy with a true out-of-sample test.  

### Generating Test Data ###

Instead of generating specific combinations of parameter values, I believe I'm going to switch to the same framework as an ABC analysis.  The following is a batch mode algorithm for generating the test and training data sets.

1.  Identify the model set (in this case, a pure neutral versus a conformist/anticonformist mixture).  
1.  Determine the parallelism with which you'll run the simulations ($P$).
1.  Establish prior distributions for each parameter in each model (basically, uniform distributions over the range of values that formerly were drawn from the configuration files)
1.  Establish a total number of samples desired for the training data set, and a total number for test data ($N_{train}$ and $N_{test}$).
1.  Foreach $N_{train,test}$, draw a model at random from the model set.
1.  For that model, draw random parameters from the prior distributions for that model
1.  Record the configuration parameters for that simulation run (or the actual command used to run that simulation) in a rotating set of files of $P$.  

Since each simulation run records the model under which it was run, we end up having $N_{train} + N_{test}$ simulations from the total set.  

Run those simulations, and then split the resulting data into training and test data, before moving onto the SVN or logistic regression analysis.  

This will improve coverage of the parameter space.  


### Is Identifiability Improved If We Know (Some) Parameters? ###

In general, the goal is to determine equifinality without reference to any unobservable parameters.  We rarely, in samples from real populations, have measurements (or even estimates) of population size, or innovation rates, or the prevalence of different modes of transmission in the population.  

But there may be certain situations where one or more parameters (but not, perhaps, all), are known for the population of interest.  For example, Jon Scholnick's data on New England gravestones has a fairly good enumeration of gravestone carvers during the period of interest.  In such a situation, we have at least an estimate of N for certain models (we may not know the population buying the gravestones, however).  In this situation, is identifiability improved if we can include population size as a predictor in our multi-logistic regression or classification procedure?  


### References Cited ###
