---
layout: post
title: Classification in CTPy (Part 1)
tags: [cultural transmission, classification, dissertation,coarse graining, simulation, ctpy]
categories: 
- project:coarse grained model
- model:ctpy
- experiment:experiment-classification
--- 

### Background ###

The research problem is to understand how the dynamics of cultural transmission processes are altered if we observe transmitted information through a classificatory filter rather than tabulating the actual copying events themselves.

I did a first implementation of this in [TransmissionFramework](http://github.com/mmadsen/transmissionframework), but even with a single classification and a couple of dimensions of underlying variation, performance really sucked.  Mainly because I was acting like a good Java programmer and writing to interfaces, using generic classes so that my framework was configurable and generic and....you get the idea.  I tried some experiments with [simuPOP](http://simupop.sourceforge.net)  earlier this year, and the performance is excellent.  And I've figured out how to do much of what I need for dissertation simulations, which is all I need.[^1]  

But for the [coarse graining project](/projects/coarsegraining/) it'll work well.  Hence, I've started coding [CTPy](http://github.com/mmadsen/ctpy), a library of Python functions and classes written to the simuPOP API for performing cultural transmission simulations.  

###  Requirements ###

The design goal is to overlay arbitrary paradigmatic classifications on top of the variation being evolved in a simuPOP simulation, and then produce class counts and richness values as we do for the raw variation itself.  General requirements:

* Many different classifications need to be overlaid on each set of simulation results.  These classifications will usually have the same dimensionality as the number of loci held by individuals, but will differ in how modes map to allelic partitions for each dimension.  
* The ability to generate random partitions of a dimension is critical, by specifying the number of modes desired, but having the "boundaries" of the allelic partitions differ.  There is code in TF which worked well for this, and could be translated, given a solution to problems described below.  
* Classification does not replace the original allelic data.  I envision that there is a data collection which carries the same simulation metadata, but reclassifies individual samples to a given classification.  More than one classification would be present for each simulation run ID.  
* Calculation of the class identity for individuals, given a classification, should not occur during simulation runtime.  This will allow classification to occur in parallel, reading data from the database, and writing new database entries.  

### Design Notes ###
The main issue is mapping the allele space to modes.  In TF and my dissertation proposal [@madsen2012proposal], I modeled trait dimensions as the unit interval $[0,1]$, with traits taking real-valued locations on the interval.  This offered an infinite-alleles model of mutation (it's always possible to distinguish two values, at least for a very large number of values given 64 bits), but a constrained method of doing allelic partitions for modes.   An example of chopping a dimension into three modes might be:

$[0, 0.4) [0.4, 0.7) [0.7, 1.0]$

Obviously, a trait with value $0.3576$ would be identified to Mode 1 in this dimension.  Simple.   Generating random partitions was also easy, or doing a hierarchy of classification levels.

In simuPOP, the KAllelesMutator I'm using operates with LONG integer values, so it's not truly infinite alleles, just many more than you'll need unless you have a giant population and a very long simulation run.  So we set the maximum allelic value (MAXVAL) when we construct the mutator, and then it seems to choose new alleles uniformly from $[0, MAXVAL]$.  

What we don't have is a good allelic distribution of initial variants -- variants appear to be sequential and taken from zero.  Either we ought to have initial alleles chosen randomly from the permissible space, or we simply have to wait until all the initial alleles are gone before we start recording data.  

Then, we can specify random partitions as fractions of MAXVAL.  Classifications could also be specified manually in the same way I did it in TF, and simply interpreted as fractions of MAXVAL.  MAXVAL itself could be calculated somehow, based on popsize and length of simulation run and mutation rate.  Or it could be set to a very large number.  Either way, it simply needs to be recorded as part of the simulation run info.

### Tasks ###

1.  Initialize KAllelesMutator with a variable, which is recorded as part of the simulation data schema to MongoDB.
2. Configure classification(s) as partitions of the unit interval
3. Mode boundaries are determined by partition values * MAXVAL
4. Need a data collection for storing the classifications and their modes
5. Need a data collection for storing individual samples post classification, with a field for the classification ID used.

### References Cited ###





[^1]:  I doubt simuPOP is the appropriate tool for some of my other [projects](/research.html), in particular 
	looking at structured information, so I may explore a lightweight discrete event simulator in Python before 
	starting that project.  









