---
layout: post
title: Experiment Plan for seriationct-1
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation]
categories: 
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriationct
---

Authors:  Mark E. Madsen and Carl P. Lipo

### Overview ###

Experiment `seriationct-1` is a first try at producing true frequency seriations from a regional cultural transmission model.  The experiment combines:

1.  A metapopulation model of unbiased cultural transmission 
1.  A temporal network model describing the evolution of demes within the metapopulation and their interaction intensities
1.  The [IDSS](https://github.com/clipo/idss-seriation) seriation algorithm

### Cultural Transmission Model ###

The CT model involves:

* Neutral copying of individual trait repertoires given Wright-Fisher dynamics
* Multiple local populations in a regional metapopulation
* Time-varying contact network within the metapopulation
* Well-mixed interaction within each deme
* Multiple dimensions of variation in the design space
* Standard "infinite alleles" innovation for each trait dimension
* Tracking both of dimension variants, and the intersection (classes) of dimensions

The source code for the model is available in the [seriationct](https://github.com/mmadsen/seriationct) repository, and is written in Python on top of the superb [simuPOP](http://simupop.sourceforge.net/) population genetics simulation framework by Bo Peng.  Data are stored in a standard [MongoDB](http://www.mongodb.org/) database, for ease of evolving the data schema as the experiment proceeds.  

### Temporal Network ###

The CT model takes a interval-style "temporal network" model [@holme2012temporal], which describes an evolving contact network as a series of network "slices" that are valid for a duration of time.  Vertices represent local populations, edges represent movement of individuals between populations, and edge weights represent the intensity of that movement and thus the potential for cultural traits to flow between subpopulations.  

The overall model is composed of a series of GML files which describe weighted graphs, with textual labels uniquely identifying subpopulations that carry over (potentially) between slices.  The GML files become a sequence of `NetworkX` graph objects, assigned to time indices after the CT model has achieved a quasi-stationary equilibrium ("burn-in") and before the end of the simulation run.  At the time index that each slice is assigned:

1.  Demes that are not listed in the new slice are removed from the metapopulation; this models a community being abandoned or going extinct.  
1.  Demes that are newly listed in the slice are added to the metapopulation by fission from one of the neighboring demes connected by an edge; individuals are seeded from that subpopulation's trait population by sampling with replacement.  
1.  The edge weights are converted into a "migration matrix" which gives the probability that an individual from subpopulation A will migrate to subpopulation B in any given simulation step (there is a configurable probability that individuals stay put, typically large).

### Experimental Setup ###

The goals of `seriationct-1` are twofold:

1.  Does this combination of factors:  regional, structured transmission, plus time averaged observations, plus classification of multiple trait dimensions into a design space of classes, yield the frequency patterns seen in archaeological seriations?

1.  Given two different patterns of regional interaction, do the resulting seriations display distinct enough solution characteristics that we can identify the interaction pattern from seriation solutions?  

The two regional interaction models examined here are:

1.  Simple distance-decay:  interaction is less frequent and likely the further away two subpopulations are from one another.
2.  Hierarchical interaction:  interaction is strongest to "hubs" and less dependent upon simple distance.

For each model, we generate multiple random instances of graphs with the specified topology, so that results are independent of the particulars of a single graph realization.  We then simulate cultural transmission on each temporal network instance, with replications.  

For each simulation run, we gather class counts from each subpopulation existing at each simulation step after burn-in.  For analysis, we aggregate all of the counts over time from each subpopulation, and then calculate the time-averaged frequency of classes.  These form the "assemblages" which are input to the IDSS seriation algorithm.  

The resulting output is an IDSS frequency seriation graph for each replication of each simulation run on each temporal network model.  

The analysis then involves studying the graph properties of these seriation solutions, and determining whether a classifier model can accurately predict which regional interaction model generated a given seriation solution.  The data set will be split 80/20 into a training and test set, balanced across the temporal network models and simulation parameters, and the ability to predict the interaction model assessed only on the test set. 



### References Cited ###

