---
layout: post
title: Semantic Axelrod - Next Steps
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Performance ###

Given a quick profiling, there aren't obvious standouts, I'm simply doing a lot of operations many many times.  But the graph library (networkx) is slow compared to others with a C/C++ backend, and I do graph operations tens of millions of times in a standard run.  So that's the obvious optimization, rewrite with a faster graph library.

### Nonequilibrium Analysis ###

I could do more static equilibrium analysis, but most of the interesting empirical hypotheses involve dynamics.  In particular, four experiments suggest themselves after building some infrastructure for it:

1.  **Evolving Learning Rates**

Holding the size of the design space and the innovation rate constant, what happens to radius and other measures as the learning rate evolves (increases)?  This is a better analysis of what happens with greater fidelity learning than comparing two static analyses with different parameters.  

2.  **Design Space Evolution**

Holding learning rate and innovation rate constant, what happens when the design space evolves?  I can implement this by configuring a design space with 16 trees, but only initializing the population from 4 of the trees (or whatever), but allowing individual innovation to access all 16.   Over a long time frame, how does the fraction of design space filled evolve?  If we keep track of the "level" of innovations -- whole new trees, or leaves on an existing tree, what do the rates of major and minor technical innovations look like?  Does breadth and radius evolve together over time?

3.  **Design Space and Fidelity**

In an evolving design space, what happens when we change the learning rate, holding the innovation rate constant?

4.  **Full Monty**

In an evolving design space, what happens when we increase both fidelity, and the individual innovation rate as the design space increases in size?


