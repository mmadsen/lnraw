---
layout: post
title: Classification Experiment Protocol
tags: [cultural transmission, classification, coarse graining, simulation, ctpy, dissertation, experiments]
category: coarse grained model project
---

### Purpose ###

The "packages" of information that people learn by observing others (e.g., craftspeople, parents) or being formally taught are variable in their "size."  This is true along several dimensions.  Two people may observe the same demonstration and retain different information.  Alternatively, a teacher may work with one student to pass on information about a whole tool or process, and with another student about an aspect of the tool or process.  And so on.  There is no "natural" unit or "package size" to cultural transmission, because culture is passed by a variety of physical and behavioral mechanisms.  

We detect and measure social learning by constructing analytic classifications pertinent to the problem domain, and then examining the abundances and spatiotemporal patterns of those classes.  Inevitably, our classifications are thus a "coarse grained" view of the actual social learning processes.  

We should not, therefore, expect that CT models derived from classical population genetics theory, or epidemiological theory, should give correct _quantitative_ predictions when we use them in a cultural context.  For example, unbiased transmission within a fixed population, with "always new" innovation, results in a distribution of trait frequencies which has a characteristic form.  

The purpose of this simulation model is to establish the formal relationship between CT models and analytic classifications, for the observable variables we seek to apply to empirical data. Specifically, I seek to understand:

1. Scaling -- how does each model observable change when we change the density of modes in a classification, or whether dimensions are broken into modes evenly or randomly?
2. Equifinality -- are there models (or parameter regions) that we can distinguish in raw trait space, but not when we observe the models through classifications (of given coarseness)?


### Experiment Outline ###



#### Simulation Steps ####

Each model runs within simuPOP, using CTPy modules.  simuPOP will perform replications of a model run at a given set of starting parameters, but different initialized populations.  So each execution of a simulation model will given $R$ replications of a specific set of parameters.  

Each simulation execution runs a specific CT copying/innovation model, with a unique combination of the model's parameters (e.g., population size, innovation rate, conformism rates).  Each replicate constitutes an independent evolving population under those specific parameters, and each replicate is sampled independently and stored independently in the database as a "sample path." 

For the basic unbiased model with unbounded "always new" innovation (WF-IA), the core parameters are:

1. Population size
2. Innovation rate

Other models such as conformism would add the conformism rate or bias level.  

#### Data Reduction Steps ####

In order to minimize the number of simulation runs, some data configurations can be derived by subsampling the results of an existing simulation run.  For example, if we are taking samples of multiple sizes from a population during a simulation run, we can simply record the largest sample size, and subsample the database for smaller sample sizes.  This is advantageous because simuPOP need not be loaded and running a live simulation to process the data stream and derive smaller samples.  

The following parameters will be handled by setting them to maximum values across all simulation runs, and generating subsample sample paths in the database in post-processing:

1. Sample size of individuals for statistics calculation
2. Number of trait dimensions each individual possesses

**NOTE** we can factor out trait dimensions in this way ONLY if we're using specific algorithms for copying and mutation.  In the unbiased case (WFIA), the simuPOP `RandomSelection` mating scheme copies a whole individual's genotype into the output population for the generation step.  And the `KAlleleMutator` applies the mutation rate to each locus independently (and can have specific mutation rates for each locus, if desired). These facts about the model code make it easy to factor out trait dimensions by subsampling.  IF, on the other hand, a CT model doesn't work this way, I may need to explicitly include `num_loci` in the simulation parameters Cartesian product.  
 

#### Analysis Steps ####







### References Cited ###


