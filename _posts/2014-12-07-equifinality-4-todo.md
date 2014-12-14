---
layout: post
title: CTMixtures Analysis -- Equifinality-4 Progress and Tasks
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories:
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Overview ###

Equifinality-4 fixes a couple of lacunae in the feature set for classification, and drops the purely sampled data set until another paper on object analysis.  It compares population census versus time averaged and sampled data, for aggregate assemblages like ceramics or lithics. I include Neiman's $t_f$ diversity measure, since it's widely used, although I doubt it tells us anything that Shannon entropy does not.   

I am not including power law exponent fits.  This may be controversial, since Premo found that they continued to have diagnostic value with time averaged data.  But Mesoudi and Lycett, and probably Bentley originally, are calculating the power law exponent in a way that seems strange with respect to **archaeologically measurable** variables, so that needs further analysis.  M&L's code (from the 2009 paper) clearly aggregates the total number of agents across the entire simulation time span that adopted a given trait.  Thus, the "frequency" of a trait in their analysis is not the fraction of $N$ (total population size) in which the trait is represented at a given point in time.  It's more like the "cumulative adoption" of a trait.  This is what gives them data points in the $10^4$ to $10^6$ range on their log-log plot when population sizes in the simulation are in the hundreds.  

When you do try to calculate the power law exponent on frequencies from a single time slice, the numbers are pretty unstable, because  in a small population none of the counts exceed N, which is on the order of hundreds.  And with a small number of traits represented in any given sample, most of the algorithms simply can't calculate the exponent.  

So I need to think more about situations where the power-law exponent does seem to be useful, and check how Premo calculated it, because in theory it seems to be robust to time averaging effects, but it's possible that this is because it's only calculable on large amounts of aggregate data.  Carl Lipo suggested something along these lines in conversation recently.


### Analysis Run ###

I started `equifinality-4` on data re-exported (with the V2.5 data export script) from the `equifinality-3` database, on 12/13/14.  The analysis is occurring on two EC2 16-core instances, and should be complete in just over 24 hours.  


