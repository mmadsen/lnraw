---
layout: post
title: Identifying Metapopulation Models from Simulated CT and Seriations 
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation, algorithms, ML]
categories:
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriation-classification
---

### Background ###

In a [previous note], I described the problem of inferring the goodness of fit between a regional network model and the sampled output of cultural transmission on that regional network, as measured through seriations.  I am now ready with the simulation and inference code to start testing the spectral similarity metric I discussed in that note across pairs and sets of regional network models.  

Here, I describe the first such comparison.

## Experiment:  SC-1 ##

SC-1 is a simple contrast between two regional network models.  A regional network model is a time-transgressive description of the interaction patterns that existed among a set of subpopulations, described by an "interval temporal network" representation (see [note 2](http://notebook.madsenlab.org/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2014/11/28/more-temporal-networks-python.html) and [note 1](http://notebook.madsenlab.org/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2014/07/28/implementing-temporal-networks-in-python.html) about the implementation of such models).  

Both models are composed of 10 time slices.

Model #1 is called "linear" in the experiment directory because it should ideally yield simple, linear seriation solutions because the only thing occurring is sampling through time.  At any given time, the metapopulation is composed of 64 subpopulations each.  Each subpopulation is fully connected, so that any subpopulation can exchange migrants with any other, and there are no differences in edge weights (and thus migration rates).  Each subpopulation in slice $N$ is the child of a random subpopulation in slice $N-1$.  

Model #2 is called "lineage" in the experiment directory because it features 4 clusters of subpopulations, with 8 subpopulations per cluster.  Subpopulations are fully connected within a cluster, with edge weight 10.  Subpopulations are connected between subpopulations at fraction 0.1, with edge weight 1.  This yields a strong tendency to exchange migrants within clusters, and at a much lower rate between clusters.  For the first 4 time slices, all four clusters of subpopulations are interconnected, but in slice 4, a "split" occurs, removing interconnections between two sets of clusters, leaving ${1,2}$ interconnected and ${3,4}$ interconnected, but no connections between these sets.  The resulting clusters then evolve for 6 more time slices on separate trajectories, giving rise to a "lineage split."

Neutral cultural transmission is simulated across these two network models, with 50 simulation replicates on each model, and a common set of parameters:

```json
{
    "theta_low": 0.00001,
    "theta_high": 0.0001,
    "maxinittraits": 5,
    "numloci": 3,
    "popsize": 250,
    "simlength": 8000,
    "samplefraction" : 0.5,
    "migrationfraction_low" : 0.05,
    "migrationfraction_high" : 0.1,
    "replicates" : 1
}
```
Innovation rates and migration fractions are chosen uniformly at random from the ranges given for each simulation run.  Each locus evolves randomly, but we track combinations of loci as "classes" in the archaeological sense of the term as our observable variables.  Populations evolve for 8000 generations, giving approximately 800 transmission events per individual during a time slice (i.e., step in the regional metapopulation evolution).  We can think of that as approximately monthly opportunities for copying artifacts or behavioral traits, over a lifetime of approximately 65 years.

The raw data from each community in a simulated network model are then aggregated over the duration that community persists, giving us a time averaged picture of the frequency of cultural traits.  

I then perform the following sampling steps:

1.  I take a sample of each time averaged data collection similar to the size of a typical archaeological surface collection:  500 samples are taken without replacement from each community, with probability proportional to class frequency.  This yields a smaller set of classes, since many hundreds or thousands of combinations are only seen once or twice in the simulation data, and thus are very hard to measure from empirical samples.

2.  I then take a sample of communities to seriate.  From each of the two network models, I take temporally stratified samples, with 3 communities per time slice sampled out of the 64 present in each slice.  In real sampling situations, we would not know how communities break down temporally, but we often do attempt to get samples of assemblages which cover our entire study duration.  In the case of Model #1, we take a 5% sample of communities in each time slice.  In the case of Model #2, given the different structure of the model, we take a 12% sample of communities in each time slice.  

3.  Within the overall sample from each simulation run, comprised now of the time averaged class frequencies from 30 sampled communities, I examine the classes/types themselves, and drop any types (columns) which do not have data values for at least 3 communities.  This is standard pre-processing for seriation analyses (or was in the Fordian manual days of seriation analysis) since without more than 3 values, a column does not contribute to ordering the communities.  

These final samples are contained in directories:

* `slice-stratified-filtered-lineage-data`
* `slice-stratified-filtered-linear-data`

The [IDSS Seriation](https://github.com/clipo/idss-seriation) package is then used to seriate the stratified, filtered data files for each simulation run across the two models.  

### References Cited ###

