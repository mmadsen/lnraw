---
layout: post
title: SeriationCT Experiment Outline
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation]
categories: 
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriationct
---

### Overview ###

SeriationCT is a pilot experiment aimed at constructing a method for linking regional-scale artifact assemblage data (e.g., the frequencies of ceramic or lithic artifact classes across many assemblages or sampling points) and metapopulation models of cultural transmission.  In our experiment, the observable linkage between a CT model and an ensemble of assemblages is an archaeological seriation.  

We believe that seriations, suitably generalized from early culture-historical practice, are an ideal "statistical summary" of the history of a metapopulation, and inherently capture the diachronic similarities between populations which are sharing cultural information.  

Several challenges exist in employing seriations as the statistical model linking empirical assemblage data to a metapopulation model. 

1.  We need to be able to perform seriations of a reasonably large number of assemblages, without reducing the problem to a lossy similarity matrix, in a bounded time frame, since we need to be able to do thousands if not millions of seriations.

2.  We need a way to compare seriation solutions and judge their distance or isomorphism.  This is a difficult problem because direct comparison of seriations as graphs renders the problem part of the "graph isomorphism" problem, which is known to be NP-hard.  Our initial approach, as with most studies employing approximate Bayesian computation (ABC), is to derive summary statistics from our seriation method and perform comparisons among summary statistics. 

3.  We need to understand the degree to which our summary statistics are "sufficient" statistics and are free from equifinalities at least with respect to the models we seek to study.  

### Outline ###

For a pilot study, I need to restrict the scope of the regional interaction models we study, given the computational cost of an ABC analysis _combined_ with IDSS seriation for each simulation.  I also need to restrict the number of sampled assemblages in order to allow reasonably fast seriation solutions.  

A good place to start would be:

1.  Generate a target seriation from each of two regional interaction models (perhaps a relatively homogeneous one versus a model with a sparser interaction matrix, perhaps a nearest neighbor model), using a large population from which we take a small sample of assemblages before calculating the seriation.   

1.  Use both models in an ABC analysis, calculating summary statistics for the simulated and target seriations and recording a distance function between simulated and target statistics.  Do this for $N = 100,000$ or $N = 1,000,000$ samples per model, depending on how fast we can simulate.  

1.  Rank the samples by distance, and then look at the top 10% or 25% of samples.  The ratio of models represented is a good approximation of the Bayes factor for model selection for the target seriation.  


### References Cited ###

