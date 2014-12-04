---
layout: post
title: CTMixtures Analysis -- Splitting the Analysis
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories:
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Splitting the Analysis in Two ###

As I was working on the analysis, I noted that a couple of measurements are missing, due to software bugs.  Census and sampled data were missing trait configuration entropy and IQV metrics, for some reason the mean of Slatkin exact scores were missing from population census data, and the Kandler survival stat was missing from sampled data.  There are still a large number of complete variables, but I think I need to fix this.

Everything but the Kandler survival stats are possible to fix by reprocessing the MongoDB database of simulation results.  The Kandler stats are done during the simulation runs themselves, and would require re-running the entire set.  

Thus, I have two choices:  

1.  Drop the Kandler variable from all of the measurement sets
1.  Drop the sampled data set from the analysis

Interestingly, a conversation with Carl Lipo helped me clarify the purpose of the synchronic/sampled measurement set.  It applies to data which are truly synchronic -- object scale analysis, or historical archaeological data where we truly can control temporal aggregation.  So that suggests a separate paper focusing upon object scale data sets.  

The current paper will focus upon aggregate data, which is what my dissertation is focused upon anyway, and I'll keep the Kandler survival analysis for a comparison of the "abstract" population census setting that Bentley, Mesoudi and Lycett, and others have done with their simulation models, and realistic time averaged and sampled assemblages.  

In the bargain, I'm going to add some derived variables like a couple of different ways of calculating the power-law exponent (since different packages give different answers), and I'm going to add Neiman's other diversity measure (since one of his measures is equivalent to Shannon entropy).  That ought to cover the spectrum of variables people use for identifying biased versus neutral models in the literature, and other variables I've come up with.  

This entails rerunning the data export and statistics from the database, and then rerunning all the gradient boosted models, and adds about a week of concerted computation and some programming, but it's the right approach.  

The resulting analysis will be called `equifinality-4`, and will hopefully be the final published experiment for this paper.   More soon.
