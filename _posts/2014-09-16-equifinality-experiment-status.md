---
layout: post
title: CTMixtures Status for Batch Equifinality-1
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### First Batch:  Equifinality-1 ###

I am starting the first batch of 40,000 simulation runs today, labeled `equifinality-1`.  The [configuration files and job scripts](https://github.com/mmadsen/experiment-ctmixtures/tree/master/simulations/equifinality-1) are located in the `simulations/equifinality-1` directory of my `experiment-ctmixtures` GitHub repository.  The gzipped tar archive `ctmixtures-equifinality-1.tar.gz` contains 400 job scripts, the simulation configuration files for each model, and a copy of the `ctmixtures-2.3` software, and can be used to replicate this experiment either with or without StarCluster, on a local computer or other cloud computing service.  

#### Models and Priors ####

All simulations are performed for 1MM steps in a Moran population dynamic with 100 individuals, so 10K generations.  

* Equal proportions of anti- and conformist transmission
* 70% conformism, 30% anticonformism
* 30% conformism, 70% anticonformism
* 100% purely neutral copying

All models share a uniform prior distribution on innovation in the range $[0.1, 5.0]$, in scaled units.  Conformist mixtures all share uniform prior distributions on the strength of the bias from the range $[0.05, 0.25]$.  

All models allow the population to reach quasi-stationary equilibrium, and take a synchronic snapshot sample of the population of two sizes:  10 and 20 individuals from the total of 100.  That synchronic snapshot occurs in time step 1MM, at the conclusion of the simulation run.  

All models also perform time-averaged observations over a set of durations $[10,25,50,100]$ generations long (nb.  1 generation = 100 time steps in this model given the conversion between WF and Moran dynamics).  

All models also calculate the Kandler-Shennan trait survival over a duration of 50 generations, both with synchronic point observations at the beginning and end of the 50 generation block, and with observations on each end which are time averaged for $[10,25,50,100]$ generations.  This will allow analysis of the effect of time averaged observations on Kandler and Shennan's non-equilibrium survival method.  

Each simulation run is given a random seed, which is saved with the simulation results, and a label indicating which model was used, which is also saved with the simulation results.  The latter will form the basis for training a classification model (SVM and random forest), and evaluating out-of-sample performance on a test data set.  

#### Timing ####

Started the 400 jobs around 9:50am on 9/16.  Projecting a completion sometime on Saturday, but some of the conformist models are taking about 3 minutes, not 4.3, so the batch could be done sooner, will keep an eye on it to minimize cost.  

#### Completion ####

The runs consistently took a shorter time than my initial tests on an EC2 instance suggested, and close to the time on my laptop, so the total wall-clock time for the 40,000 runs was around 54.5 hours.  Execution costs were $120.00 almost exactly.  


