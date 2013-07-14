---
layout: post
title: Classification in CTPy
tags: [cultural transmission, classification, coarse graining, simulation, ctpy]
category: "coarse grained model project"
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

### Issues ###


### Design Notes ###




[^1]:  I doubt simuPOP is the appropriate tool for some of my other [projects](/research.html), in particular 
	looking at structured information, so I may explore a lightweight discrete event simulator in Python before 
	starting that project.  









