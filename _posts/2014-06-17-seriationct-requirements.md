---
layout: post
title: Requirements for SeriationCT Model
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation]
categories: 
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriationct
---

### Description ###

The `seriationct` model is intended to represent a regional-scale model of coarse grained cultural transmission, occurring in a set of local populations which interact among themselves and between demes.  Their interaction occurs according to a diachronic model which specifies a weighted adjacency matrix as a function of time where the entries are pairs of demes.  Individuals are connected between demes at the density given by this time-dependent adjacency matrix.  

In addition to the diachronic connectivity model, there is a time-dependent demographic model, which specifies how demes are added and become extinct to the metapopulation.  When a new deme is formed, it is seeded by a sample of individuals from surrounding demes, and connected according to the connectivity model.  The "diachronic connectivity model" and a specific history of demes is effectively what we want to infer from samples, or at least equivalence classes of such models.

Cultural traits are learned between individuals given a standard neutral Moran process across the individual-level network, with infinite-alleles innovation/mutation occuring across the ensemble of demes.  The innovation rates may be constant across demes, or variable across demes.  Initial modeling will focus upon the constant innovation rate case.

Analysis of the model occurs by taking coarse grained samples of trait frequencies which approximate several key features of real archaeological phenomena:

1.  Samples are accumulated over a varying range of durations, to simulate time averaged deposits.
1.  Samples are identified to a paradigmatic classification (or classifications) 
1.  Samples are labeled as to deme of origin

The resulting samples are then available for seriation and other statistical analyses, to measure the ability to infer the history of demes, and elements of the diachronic connectivity model.   


### References Cited ###

