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

The `seriationct` model is intended to represent a regional-scale model of coarse grained cultural transmission, occurring in a set of local populations which interact within and between demes.  Interaction within a deme is assumed to be well-mixed, and in general given the 
[effects of coarse graining on mixtures of social learning rules](/project:coarse%20grained%20model/model:ctmixtures/experiment:experiment-ctmixtures/2014/04/26/ct-mixture-experiment-design.html), transmission is modeled as unbiased copying.   

Interaction of individuals between demes occurs according to a diachronic model which specifies:

1.  Which demes are connected, and which lack connections
1.  The normalized strength of the connection, or weight

This model can be represented by a time-indexed set of weighted adjacency matrices, and is a "temporal network" in the sense studied by [@holme2012temporal].  During interactions, individuals are given neighbors in connected demes in proportion to the weights, to allow a normal "choose a random neighbor" algorithm to represent both intra- and inter-deme copying.  This is an implementation detail, and is not crucial to the model.  

In addition to the diachronic connectivity model, there is a time-dependent demographic model, which specifies how demes are added and become extinct to the metapopulation.  When a new deme is formed, it is seeded by a sample of individuals from surrounding demes, and connected according to the connectivity model.  This implies that the matrices which form the temporal network described in the previous paragraph do not always have the same size.    

The "diachronic connectivity model" and a specific history of demes is effectively what we want to infer from samples, or at least equivalence classes of such models.

### Sampling ###

Observables are calculated by taking coarse grained samples of trait frequencies which approximate several key features of real archaeological phenomena:

1.  Samples are accumulated over a varying range of durations, to simulate time averaged deposits.
1.  Samples are identified to a paradigmatic classification (or classifications) 
1.  Samples are labeled as to deme of origin

The resulting samples are then available for seriation and other statistical analyses, to measure the ability to infer the history of demes, and elements of the diachronic connectivity model.   


### Analysis ###

TBD.

### References Cited ###

