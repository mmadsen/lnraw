---
layout: post
title: Knowledge Prerequisites and Graph Symmetries
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Brief Summary ###

In my [last note](/structured%20information%20project/2014/01/11/semantic-axelrod-prerequisites.html), I ended by talking about how to measure the symmetries and structure of the trait tree which result from our tree-structured Axelrod model.  

Because the traits here are abstract (and thus exchangeable, except for their structural roles within the trait networks), we are not interested in exact trees.  Instead, what we want is a measure of "classes of shapes" of trees during and after the social learning process.  This is captured by understanding the symmetries of trees of traits, and in particular the "equivalance classes" of vertices that have the same number of children, given a single parent in the tree structure.  This notion is captured by the "orbit structure" of the automorphism group of the graph of traits [@godsil2001algebraic].  

In this note, I delve into (some of) the details of this, and establish the measures I will use for simulations for our SAA paper and Springer volume paper.  

### Initial Situation ###

As I mentioned before, for simplicity and a good null comparison, I start with a trait "universe" (or design space, sensu [@o2010cultural]) which is composed of $T$ different fully balanced trees with $(r,h)$ branches and height.  The root of each tree represents some basal prerequisite skill or concept for each of the traits below it in the tree, and each parent represents a prerequisite for the traits below it.  

To make this concrete, as in many of my early simulations, I work with a branching factor $r$ of 4, and a height $h$ of 4.  This constructs an initial trait tree of 341 traits, with 256 traits at the leaves ($4^4 = 256$).  If we consider this set of traits to be individually unique, there are an enormous number of combinations of traits that any one individual could possess.  (For reference, the number of permutations of 341 elements is on the order of $10^{717}$).  

Continuing the focus on a "full" initial trait tree (keeping in mind that the simulation uses $T$ of these in a population, to represent differing sets of concepts/skills/traits), each tree is fully balanced, which means it starts out with the same number of traits at each level, and the same depth on each branch.  This means that each vertex at each level is "equivalent" to its siblings at the same level -- structurally, it possesses the same number of children and one parent, and thus is symmetric and interchangeable (ignoring its actual semantics) with other vertices at its level.  

What this means formally, is that there is an _automorphism_ from vertex $X$ at level $h$ to all other vertices at the same level, and thus the vertices at a particular level $h$ belong to the same equivalance class.  This means that the automorphism group $\textit{Aut}(G)$ for the initial trait graph has $h+1$ or 5 _orbits_. This is confirmed by feeding one of the initial trait graphs to the `nauty` program `dreadnaut` and asking for the basic summary and orbit structure [@McKay201494].  

Sample output for a full initial trait graph looks like this (all but the last four lines removed): 

```
level 1:  5 orbits; 21 fixed; index 64
5 orbits; grpsize=2.079483819622e117; 255 gens; 30388 nodes; maxlev=205
cpu time = 0.04 seconds
 0; 1:4 (4); 5:20 (16); 21:84 (64); 85:340 (256);
```

As we can see from the last line, the vertices at each level are equivalent to each other, but not equivalent across heights in the tree.  The root is its own equivalance class, there are $r=4$ vertices in the level directly below the root, and so on.  

Thus, the initial condition for the simulation will always be that each of $T$ trait graphs has 5 orbits among 341 vertices.  We would expect that the tree-structured Axelrod graph, as it winnows this initial design space, will end up with trait configurations that are:

* Much more asymmetric, and
* Much richer in vertices with specific symmetries at a given level

and thus, will have more orbits with fewer vertices in each orbit. 

Furthermore, two trait trees with the same orbit structure and number of vertices are an _equivalent_ outcome to the simulation process, despite the stochastic nature of the copying rules.  

### Winnowed Graphs ###

I'm still writing the code to automatically sample trait graphs through the simulation (without killing its performance) and calculate their symmetries and orbit structure, but I captured a couple of graphs at final convergence, and this is what one looks like:

```
20 orbits; grpsize=1152; 9 gens; 53 nodes; maxlev=9
cpu time = 0.00 seconds
 0; 1; 2; 3; 4; 5; 6 7 (2); 8; 9; 10; 11 13 (2); 12; 14; 15:17 (3); 18:21
    (4); 22; 23; 24:26 (3); 27 30 (2); 28 29 (2);
```

Note that there are only 30 vertices left; this was a simulation run with very low rates for innovation and individual learning, but slightly higher random loss of traits.  The resulting graph (which, sadly, did not render well in Graphviz), showed a "spindly" structure with a few ramified trees down to the roots and a few "shoots" with single paths leading from the root to the leaves.  

This is reflected in the statistics:  20 orbits instead of 5, and most orbits have 1 vertex in them, a few with 2, 3, or 4 equivalent vertices.  

**Why is this a good compact description of the structure?**  Well, there are 30 vertices left in the trait graph, and 17 of the vertices are "leaf" or terminal nodes.  The _Narayana number_ for such graphs describes the number of ordered trees with $n$ vertices and $k$ leaves, and is:

$|S_{n,k}| = \frac{\binom{n-2}{k-1}\binom{n-1}{k-1}}{k}$

This number, for 30 vertices and 17 leaves, is on the order of $10^{14}$.  Still a very large number of possibilities.  Of these, we are concerned only with a small fraction which possess 20 orbits and the orbit structure given above.  The latter is like a "fingerprint" for the symmetry structure of the resulting trait trees, picking out a tiny fraction of the possible trees as the result of a particular social learning and drift process.  


### Measures ###

Thus, in addition to the relatively crude ratio of actual to total possible vertices in a sampled trait graph, we can divide the sampled trait graphs into equivalance classes which measure their "shape" in terms of symmetries which preserve graph structure.  These will be the basic structures that I measure in a final converged simulation, and which I count for frequency distribution in the quasi-stationary but transient portion of simulation runs. 

The distribution of orbit structures is, therefore, the abstract measure of the "structure of knowledge" that the "tree structured" Semantic Axelrod model has as its outcomes.  

More when the simulation runs have finished running....

### References Cited ###



