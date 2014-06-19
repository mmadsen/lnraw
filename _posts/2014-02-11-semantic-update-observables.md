---
layout: post
title: Update on Tree Structure Models and Observable Variables
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Status: 2/11/14 ###

`saa-experiment-1` is running right now, using tagged version `v1.1`.  The experiment is running across 3 machines, so the databases will need to get merged.  This version of the simulation produces a row of data for each parameter combination/replicate, for each culture "region."  The row of data has summary statistics for all of the trait trees (or connected components) in that culture region, and a count of the number of agents for that region.  

For a converged solution, the sample will typically (though not necessarily) be a single culture region, and thus one row of data.  Typically, each culture region in a converged solution will be an average over some number of trait trees less than or equal to the configured number of trait trees.  

In a sample from an unconverged simulation run, there may be more "trait trees" than the configured number, because traits held by individuals may not be fully connected if the "loss rate" is positive (since it causes random losses of traits without respect to the prerequisite structure).  

### Status: 3/10/14 ###

`saa-experiment-1` ran for two weeks and did not finish.  One of the problems is that the simulation undergoes a drastic slowdown when the number of active links is very very low, possibly because we do nothing but check for active links in a tight loop without finding any.  

But the bigger problem is that the code for creating `dreadnaut` format graphs for the `nauty` algorith had a bug, and was capable of scrozzling the graphs.  I found and fixed this, and also changed from doing tree-by-tree analysis to analyzing the entire trait tree, [given some analysis](/structured%20information%20project/2014/03/10/symmetries-multiple-tree-components.html).

In manual experiments, I'm seeing variation in the groupsizes, orbit numbers, and orbit multiplicities (I'm also calculating and storing the max and mean multiplicities for each forest).  So now the task is to see what the real range of variation is over learning rates, and state space sizes.  










