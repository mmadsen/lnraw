---
layout: post
title: CTMixtures Equifinality - Calibration Issues and Solutions
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Calibration Issue ###

I'm throwing out the data from `equifinality-1` because I believe the innovation rates were off in the simulation code.  The observed number of variants in the population were much higher than I'd expect given the Wright-Fisher estimates from the frequency spectrum, so I checked deeper with both population and sampled data.  It wasn't simply a factor of two, either, which is the usual difference between WF and Moran dynamics for some quantities.  

I looked at Ewens [-@Ewens2004] again, and added a method to the `pytransmission` library to calculate the expected number of alleles in a sample, and its variance, given Equations 3.83 - 3.86.  

I also:

1.  Changed the formula for turning the scaled innovation rate ($\theta$) into a per-individual/locus rate ($\mu$), choosing a simpler formula rather than solving the formula 3.98 in which a factor $\mu / (1 - \mu)$ occurs.  Instead, $\mu$ is calculated simply as $\theta / N $.    
1.  Stopped using the "random locus" copying rule for neutral traits, since the Moran model is defined to have a whole individual drop out and be replaced by a clone of another individual.  

These changes are split across the `ctmixtures` and `pytransmission` codebases, involving at most single lines of code in several places. 

### Difference in Copying Algorithm and Calibration ### 

One potential issue is that I have two possible implementations of a neutral copying model, and one for frequency-dependent bias.  

1.  Neutral - copying events copy the whole individual (all loci)
1.  Neutral - copying events copy a single locus at a time
1.  FD Bias - copying events copy a single locus at a time

There is, in a sense, no "right" way to write a copying algorithm.  Most cultural evolutionary models of bias in the anthropological literature employ a single locus, and thus there is no difference.  In the genetic case, "all-locus" copying is overwhelmingly more common than single locus copying, due to the nature of genetic replication.  

In the cultural case with many traits, it is distinctly a _modeling choice_.  We might postulate, for example, that "all-trait" copying is likely prevalent only in early childhood development and social learning, when children are exposed to their parent's cultural repertoire at high frequency and intensity.  In contrast, we might expect that single trait copying would be the typical mode for adult individuals, as they engage in social learning within a specific task or context, with consequently smaller changes in their overall repertoire.  This kind of developmental change, incidentally, may help account for why some aspects of cultural repertoires exhibit slow change empirically, despite the rapidity with which traits turn over in our simple models.  By narrowing the "volume" of a repertoire that is changed at any given time as an adult, cultural evolution becomes "conservative" without necessarily employing frequency-dependent bias or homophilic preferences.  

So, in a sense, we could consider equifinality issues between both "all-locus" and "single-locus" neutral models, and bias models with both types of copying.  Currently, the design of the FD bias algorithm makes it difficult to perform an "all-locus copy", and it's not entirely clear what it means to perform a biased copy of "most common" or "least common" traits.  Do we:

1.  Copy all of the traits of the individual who possesses the highest number of "most common" traits at the various loci?  
1.  Copy the most common traits from each locus, regardless of whether they come from the same individual?  
1.  Copy all of the traits of the individual who has the single most popular trait, regardless of locus?  


One way to resolve this issue is to restrict the current study to copying models which are most realistic for adult learners:  single trait copying models.  Employing the `NeutralRandomLocusCopyingRule` in direct comparison to the `BaseNeighborConformismRule` in `ctmixtures` creates an apples-to-apples contrast.  

The downside is that the neutral single-locus copying rule does not directly calibrate with the analytic expectations of the Moran infinite-alleles process, as described by Ewens, but today's multiple calibration runs sheds light on why this is the case.  

I feel comfortable configuring simulation runs for `equifinality-2`, using the revised code, which will be released as Version 2.4.  


### References Cited ###

