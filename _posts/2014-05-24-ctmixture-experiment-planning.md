---
layout: post
title: Experiment Planning for CT Mixture Model
tags: [cultural transmission, coarse graining, simulation, dissertation, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Planning:  CT Mixtures and Identifiability ###

#### Features ####

1.  Configuring a population with any number of interaction rules, given by proportions of the population to which they apply.  
2.  Random assignment of those configuration rules to agents, given proportions.
3.  Location of agents on a network of some kind (currently defaulting to a square lattice).
4.  Separate configuration of conformism and anticonformism "strengths". 
5.  Global innovation using the "infinite alleles" model.
6.  Multiple loci evolve simultaneously, but only one change per tick (i.e., Moran or discrete-approximation-to-continuous) dynamics.
7.  Tracking of both allele frequencies, and multiple locus "configurations" (i.e., the genomes). 
8.  Sampling calculates richness, evenness, slatkin exact tests per locus and for configuration counts among the whole population.  

#### Limitations ####

1.  Parameters like conformism, innovation rates, are "global" and not assigned on a per-agent basis.  This is conventional in most published work, but it's time to start incorporating such heterogeneity in our models.  
2.  Still have to ensure that population size correct as a perfect square, to ensure that it's easy to make a square lattice.  I could automatically round it, but then it would be easier to accidentally run different simulations at different sample sizes, when you intended them to be the same.  Probably will not fix this.  
3.  I do not have time averaging built in, and it's hard to do it by post-processing.  This might need to be the next extension.  

#### Experiments ####

After I finalize some data format issues, the following experiments:

1.  