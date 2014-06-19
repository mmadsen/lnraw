---
layout: post
title: TODO for Semantic Axelrod project
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod]
categories: 
- project:coarse grained model
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Update ###

A bug in the innovation code was causing innovations not to happen unless a copying event also happened.  I am scrapping previous data because even though the case $\mu = 0.0$ might be alright, 
I also think that we need to be comparing time slices, and the new data seem to have different mean 
values for some of the key measurables.  So I'm going to blast a new set of runs.  

Changes:

1.  Simulations run to 10 million ticks, regardless.  We sample from 6MM to 10MM ticks, every 1MM ticks taking a sample, giving us 5 samples per simulation run (to detect non-stationarity).

2.  I record the timing of runs.  Currently, on my laptop and EC2 instances of type `C3.xlarge`, a run with 100 individuals takes 227 seconds, 225 individuals takes 293 seconds, and 400 individuals takes 372 seconds.  This will allow some predictability in completion times.  There is very little variation since we are doing 10MM ticks, regardless of the copying and innovation events involved.  

A small test run with learning rates of `0.1` and `0.8` was encouraging, things look different for some observables and not others.  I think we're ready to go.  

I also learned that the $r=6, h=6$ case for trait trees is simply too large to do automorphism group calculations upon.  


### Production Experiments ###

The following will be divided into 6 different machines, 2 each for population sizes 100, 225, 400.  Each population size will finish at different times, and their server instances deactivated.  The anticipated range is between 4 (size 100) and 6.5 days (size 400)

* Learning rate:  0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9
* Population size:  100, 225, 400
* Replications: 50
* Trait trees:  4, 16
* Branching factor:  3, 5
* Depth factor: 3, 5
* Max init traits: 4
* Innovation rate: 0.0000, 0.00005, 0.0001


### Experiment Log ###



