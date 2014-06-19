---
layout: post
title: Notes on He and Stone 2003
tags: [reading notes, coarse graining, synchronization theory]
categories:
- project:coarse grained model
- reading notes
---


## [@hestone2003] Notes ##

He and Stone analyze the conditions under which there is large scale "in phase" versus "anti-phase" synchronization between communities in a local metapopulation [@hestone2003].  They don't really model the details of a complex network, in section 2 AFAIK they're randomly assigning links, which means that the intra-population network is going to be an ER graph.  

They use a control parameter, the "link ratio," which measures the number of inter-population links over the number of intra-population links (or, the fraction of edges in the overall network which cross populations).  

The order parameter is the phase difference between populations, where the "phase" of an infection is [@pikovsky2003synchronization] equation for the phase of a time series, given parameters which seem to be various ordered "maxima" of the time series (NEED TO EXAMINE). 

This is starting to make sense in terms of how to calculate the "synchronization" of something like a spreading process which fundamentally isn't a strict oscillator (without dealing with the complications involved in a full chaotic oscillator model, or maybe it is....?)

The basic conclusion here is that low levels of coupling (i.e., low LR) tend to lead to anti-phase synchronization, and high levels of coupling bring the population into strict synchronization.  In-phase synch gives an order parameter near zero, while strict anti-phase sync leads to an OP of pi.  

### Connection to Seriation ###

Several questions arise.  

1.  All of the inphase/anti-phase stuff here is very short-term.  There still is a renormalization aspect to figure out what survives when we "zoom out"....
1.  How do we connect the *failure* to include assemblage A into a seriation with assemblages B-G (as an example), with the order parameter for phase differences?  
1.  When we order assemblages via seriation, we're actually putting one *before* another, which is a statement of how two assemblages relate temporally (or spatiotemporally), so technically we're making a statement that B and C are not "strictly contemporaneous," and our phase synchronization stuff here presumes that communities are strictly contemporaneous.  

SO, I need to examine the longer-term empirical studies, on measles, and look at how things synchronize when we look at longer spans of time (over a human lifetime).  

### References Cited ###

