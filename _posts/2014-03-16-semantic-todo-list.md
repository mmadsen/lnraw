---
layout: post
title: TODO for Semantic Axelrod project
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

UPDATE:  After finding a bug in the timing of innovation/mutation, I'm not using any of the previous data.  


### Deprecated Simulation Runs ###

#### SAA-5 -- server sa1 ####

Designed to allow comparison of innovation rate + learning/prereq vs just learning/prereq.  Learning rates are the same as saa-2, but a smaller set of trait spaces are examined (dropping the 4/4 pair). 

* Learning rate:  0.025, 0.05, 0.1, 0.2, 0.3, 0.4
* Population size:  100 for all runs
* Replications: 10
* Trait trees:  8, 16
* Branching factor:  3, 4, 6
* Depth factor: 3, 4, 6
* Max init traits: 8, 16
* Innovation rate: 0.000025

2160 total runs

332 on the restart, Weds 3/26


#### SAA-6 -- server sa5 ####

Intended to get more samples for an overlap of SAA-5 and SAA-2.  Only the largest and smallest trait space sizes are used, but all the learning rates, and both mutation and no mutation cases.  For these parameter combinations, we will end up with 30 replications per param combo.  

* Learning rate:  0.025, 0.05, 0.1, 0.2, 0.3, 0.4
* Population size:  100 for all runs
* Replications: 20
* Trait trees:  4, 16
* Branching factor:  3, 6
* Depth factor: 3, 6
* Max init traits: 8
* Innovation rate: 0.000025, 0.0

1920 total runs

1190 runs at 6:45pm Weds 3/26

#### SAA-9 -- server sa8 ####

SAA-8 finished quickly, so I'm going to explore larger population sizes.  If I can examine the effects both of creating high-fidelity learning AND demography, that will be interesting.


* Learning rate:  0.5, 0.6, 0.7, 0.8, 0.75, 0.85, 0.90, 0.95
* Population size:  225, 400
* Replications: 40
* Trait trees:  4, 16
* Branching factor:  3
* Depth factor: 3
* Max init traits: 8
* Innovation rate: 0.000025, 0.0

2560 runs

Started 8:35am Sunday 3/30


### Simulations COMPLETED ###

#### SAA-2 ####

* Learning rate:  0.025, 0.05, 0.1, 0.2, 0.3, 0.4
* Population size:  100 for all runs
* Replications: 10
* Trait trees:  4, 8, 16
* Branching factor:  3, 4, 6
* Depth factor: 3, 4, 6
* Max init traits: 4, 8, 16

Data moved back to Kimura in `~/local-research/semanticaxelrod/rawdata/`


#### SAA-3 -- server sa3  ####

Smaller sample size experiment, duplicates learning rates and other param values from SAA-2

* Population size:  49, 64

**Completed early morning Thursday 3/20.**

#### SAA-4 -- server sa4 ####

Larger sample size experiment, duplicates other param values from SAA-2

* Population size: 225, 400
* Learning rate:  0.1, 0.2, 0.4

4860 total runs

Killed it, and used just the 2430 runs for popsize 225.


#### SAA-7 -- server sa7 ####

Intended to test whether graphs really do change at high learning rates -- testing whether learning
environment really changes the cumulation of cultural information

* Learning rate:  0.5, 0.6, 0.7, 0.8
* Population size:  100 for all runs
* Replications: 20
* Trait trees:  4, 16
* Branching factor:  3, 6
* Depth factor: 3, 6
* Max init traits: 8
* Innovation rate: 0.000025, 0.0

1280  total runs

#### SAA-8 -- server sa8 ####

Given interesting phenomena at 0.7 and mainly 0.8 learning rates, I'm testing more of the high 
learning rates.  The small state spaces are most sensitive because everything gets lost in the 
vastness of larger state spaces.  

* Learning rate:  0.5, 0.6, 0.7, 0.8, 0.75, 0.85, 0.90, 0.95
* Population size:  100 for all runs
* Replications: 40
* Trait trees:  4, 16
* Branching factor:  3
* Depth factor: 3
* Max init traits: 8
* Innovation rate: 0.000025, 0.0

1280 runs

Started 9:50pm Sat 3/29




### Code ###

1. Finish the DOT export code so I can give it a file with ID's -- for getting, say, all of the graphs that have the same learning rate, or state-space configuration.  


### Analyses ###

For finalized runs only:

1. Symmetry at a given trait-space size, by learning rate
1. Symmetry at a given trait-space size, by learning and innovation rate
1. Symmetry at different population sizes

### Graphs/Tables ###

TBD

### Documentation Bits ###

Creating a movie from a bunch of DOT files works like this:

```
analytics/export-traitgraph-to-graphviz.py --experiment saa-2 --action sample --ssize 100 --directory tmp

for d in `ls *.dot`; do ( dot -Tpng $d -o $d.png; echo "$d.png 300" >> build ); done

~/bin/makeQuickTime.py build test.mov
```



