---
layout: post
title: SeriationCT Sample Size Series experiments
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation]
categories: 
- project-coarse grained model
- model-seriationct
- experiment-experiment-seriationct
---

### Effect of Varying Sample Size ###

After SAA's, I used some existing simulations (seriationct-27 from the [experiment-seriationct-2](http://github.com/mmadsen/experiment-seriationct-2) repository) to prototype examining the effects of sample size on:

1.  The gross structure of the seriation solutions:  how much branching when small?  do we get isolates?  
1.  Lineage structure recovery

Working with the existing simulation results and post-processed samples, I wrote a quick modification of the assemblage sampler called `seriationct-sample-assemblages-for-samplesize-sequence-seriation.py`.  The script takes the output from the `seriationct-export-data.py` script and performs subsampling as follows:

1.  Uses a `samplefraction` parameter to select an initial sample of assemblages, just like the normal `seriationct-sample-assemblages-for-seriation.py`.  
1.  Selects these samples given the `sampletype` parameter, as a pure random sample of assemblages, a spatially stratified sample given NxN quadrats, temporally stratified given N even periods of time, and spatiotemporal sampling which stratifies by quadrats and periods.
1.  Subsamples the `samplefraction` assemblages in a sequence decreasing by 2, so for example, if `samplefraction` is 30, the largest set of assemblages will be 30 randomly sampled, and then 28 sampled from the 30, 26 sampled from the original 30, and so on.  

The net result is a nested series of samples (rather than independent random samples of different sizes).  

### Statistics Brainstorm ###

Some of the things I want to know are:

1.  How consistent is the lineage structure of each seriation solution, at each sample size?  (i.e., along a branch, how mixed are lineage identifiers?)
1.  How consistent is the temporal sequence of the solution?  
1.  How "branchy" is the solution?  
1.  Furthermore, what is the average and variance of these measures, across the sequence of sample sizes?  Or perhaps the quantiles and order statistics?
1.  At what sample size does lineage structure and chronology become visible and semi-stable?  

I'm just starting to build measures for these items, since they involve traversal and parsing of the annotated minmax graphs.  



### References Cited ###

