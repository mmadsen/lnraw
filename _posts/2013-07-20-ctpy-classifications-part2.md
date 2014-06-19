---
layout: post
title: Classifications in CTPy (Part 2) --  Modeling Dimensionality, Performance
tags: [cultural transmission, classification, dissertation,coarse graining, simulation, ctpy]
categories: 
- project:coarse grained model
- model:ctpy
- experiment:experiment-classification
---

### Background ###

In [Part 1](/coarse%20grained%20model%20project/2013/07/13/ctpy-classification-designs.html) of this topic, I brainstormed the requirements for doing arbitrary classifications in CTPy, post-processing the output of cultural transmission simulations in simuPOP through paradigmatic classifications [@Dunnell1971].  

I have done an initial implementation of classification, which combines:

* A python module which defines even and random partitions of the allele/trait space, mapping them to modes for each classification dimension.
* This is limited to equal numbers of modes per dimension at present, but needs to be extended to unequal numbers of modes per dimension at some point.
* A script which generates an even or random partition of the allele space and post processes the "individual_samples" data collection in MongoDB to a collection called "individual_samples_classified."  


### Performance Considerations ###

Doing about 4000 samples (i.e., a replication at a time slice), with 10 individuals each (i.e., 40K class identifications), takes about a second.  This may be fast enough, especially if multiple script instances are launched for a set of simulation run ID's, or the primary data set is partitioned for processing along some dimension.  Or if we shard the primary database, and run a processing script instance per shard.  


### Ideas About Classification Requirements ###

In order to look at how CT observables scale with classification changes, I need a standard set of classifications against which to analyze all simulation runs.  Those simulation runs **should** all have the same MAXALLELES value, since that value is just mimicking infinite-alleles mutation in a framework which has to have a fixed integer representation of allele values.  

So two things can vary between classifications:  number of dimensions, and number of modes per dimension.  

For the first stage of experiments, I am assuming that trait dimensions are equivalent to classification dimensions.  This need not be the case, of course.  We can easily imagine cases where the transmitting individuals learn or transmit information in different size "chunks" or levels of granularity.  We may look at objects, and consider different elements to be analytically separable, regardless of the "chunk size" (or realistically, sizes) at which they were learned or taught by the constructors of the artifacts we're analyzing.  

It's complex to represent classifications of a different dimensionality than the allele/trait space in the absence of a representation of a "phenotype" that can represent the nexus of both observations and transmission/construction.  So that case should wait, probably, until I make progress on the [embodied CT and niche construction](/projects/nicheconstruction/) project.  One of the infrastructure elements that will come out of that project will be an explicit representation of "objects" in the simulation space, which are created, can be observed and imitated, and suffer destruction.  

Before that's available, I'll start by examining variation in the way we "cut up" dimensions into attributes/modes, with the assumption that classification dimensions are equivalent to chunks of transmitted information.  The difference will be that analytically we may chop a dimension of variation into different chunks than the original transmission of that variation did.   

#### Number of Dimensions ####

Dynamical systems, particularly those with interaction between agents/elements, are understood to have collective behavior which differs depending upon the dimensionality of the state space.  Thus, I'll study transmission in systems with 2, 3, 4, 6, and 8 dimensions of trait transmission, coarse-grained through classifications of identical dimensionality.  

#### Number of Analyses Required ####

This creates a fairly large analytic burden.  If we do 3 different models (e.g., unbiased, conformist, mixture), for a variety of different mutation rates, conformism rates, and population sizes, we should capture different sample sizes from each run of these models, and then also do those combinations for different dimensionalities.  For each of these combinations, there are obviously some number of replicates while we hold everything else constant.  This defines some number, $N_r$ of unique "simulation run sample sets."

We would then analyze each of the $N_r$ against $N_d$ classifications, where $d$ denotes the trait dimensionality of each "SRSS."  We might also apply $N_{ta}$ levels of time averaging to all of this.  

I should develop a Rmarkdown analysis of this, on the analogy of the seriation combinatorics note, to give me a good estimate of how many analytic data samples I'll end up with.  


#### Uniform/Even Modes ####

The first requirement is to aggregate variants into even-sized clusters.  An example of this in real analyses might be edge angles on stone tools, where a continuous variable is discretized, and archaeologists tend to discrete-ize fairly evenly. Many variables are represented by cutting a continuum into pieces relatively evenly.  

At an abstract level, we represent this by chopping the available trait space into even-sized chunks, in this case by cutting MAXALLELES into 2,3,4,6,8,12,16,32 modes per dimension.  These are standardized across many simulation runs and classifications, so we need only construct and store these for a given MAXALLELES value, and can re-use them.  

#### Random Modes ####

Tje second requirement is to aggregate variants into uneven, random sized clusters.  The analog here is any set of artifact variants which belong to "nominal" scale classes. Pottery decorative elements are an excellent example:  there is no "metric" on the space of variation, and little reason to suppose that our analytic categories "cut" a dimension of variation in pieces that reflect anything about past social learning.  

A random dimension with $k$ modes is constructed by generating $k-1$ random values between 0 and 1, and using these variates as the "internal" boundaries between modes.  This generates $k$ partitions of the unit interval.  These partitions are then multiplied by MAXALLELES to generate partitions of the trait space.  

In order to understand the behavior of classifications with random dimensions, we need to look at the same trait configuration through the lens of many instances of a random dimension.  So, for a dimension with $k$ modes, we generate NUM_REPLICATES_FOR_RANDOM_DIMENSION_MODES (typically, 20) different random mode partitions, and we apply ALL of them to each simulation run.  

Class identification is fast, but this still implies identifying the same data to 20 different versions of each classification, in addition to the classifications with even/uniform modes.  Luckily, class identification is done on each sample or observation independently, so it's a good candidate for partitioning the raw simulation data and doing identification in parallel.  

### References Cited ###



