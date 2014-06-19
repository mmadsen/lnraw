---
layout: post
title: Classification Experiment Protocol
tags: [cultural transmission, classification, coarse graining, simulation, ctpy, dissertation, experiments, experiment-classification]
categories: 
- project:coarse grained model
- model:ctpy
- experiment:experiment-classification
---

### Purpose ###

The "packages" of information that people learn by observing others (e.g., craftspeople, parents) or being formally taught are variable in their "size."  This is true along several dimensions.  Two people may observe the same demonstration and retain different information.  Alternatively, a teacher may work with one student to pass on information about a whole tool or process, and with another student about an aspect of the tool or process.  And so on.  There is no "natural" unit or "package size" to cultural transmission, because culture is passed by a variety of physical and behavioral mechanisms.  

We detect and measure social learning by constructing analytic classifications pertinent to the problem domain, and then examining the abundances and spatiotemporal patterns of those classes.  Inevitably, our classifications are thus a "coarse grained" view of the actual social learning processes.  

We should not, therefore, expect that CT models derived from classical population genetics theory, or epidemiological theory, should give correct _quantitative_ predictions when we use them in a cultural context.  For example, unbiased transmission within a fixed population, with "always new" innovation, results in a distribution of trait frequencies which has a characteristic form.  

The purpose of this simulation model is to establish the formal relationship between CT models and analytic classifications, for the observable variables we seek to apply to empirical data. Specifically, I seek to understand:

1. Scaling -- how does each model observable change when we change the density of modes in a classification, or whether dimensions are broken into modes evenly or randomly?
2. Equifinality -- are there models (or parameter regions) that we can distinguish in raw trait space, but not when we observe the models through classifications (of given coarseness)?


### Experiment Outline ###

Each model runs within simuPOP, using CTPy modules.  simuPOP will perform replications of a model run at a given set of starting parameters, but different initialized populations.  So each execution of a simulation model will given $R$ replications of a specific set of parameters.  

Each simulation execution runs a specific CT copying/innovation model, with a unique combination of the model's parameters (e.g., population size, innovation rate, conformism rates).  Each replicate constitutes an independent evolving population under those specific parameters, and each replicate is sampled independently and stored independently in the database as a "sample path." 



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


### 



### References Cited ###


