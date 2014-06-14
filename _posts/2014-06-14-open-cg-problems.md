---
layout: post
title: Open Problems in Coarse Grained CT Theory
tags: [coarse graining, cultural transmission, open problems]
category: coarse grained model project
---

### Convergence and Basins of Attraction ###

We can often identify detailed social learning rules through their frequency characteristics in "pure populations" of such learners, and in experimental situations.  In heterogeneous populations, where individuals display a mixture of social learning rules, I expect that it will be difficult to do so from bulk or CG samples of the population as a whole.  This will even be true for partitions of the population (e.g., spatial aggregates) unless social learning rules are assortative with respect to population partitions.  

Thus, I expect that combinations of fine grained models will converge to some "averaged" state.  Questions include:

1.  Is this averaged state equivalent to a population in which copying is unbiased and random (i.e., the neutral model, an Ising model with no external field, etc)?
1.  What is the relaxation time to convergence?  If the convergence time is fast, especially in the small populations we deal with, then we wuld always expect populations to appear to be converged, and we would never see far-from-equilibrium states that "look like" other social learning rules.  
1.  Are there social learning rules which are outside the basin of attraction of this convergence?  In other words, can we detect some rules but not others?

If there is a strong warrant for a convergence structure to coarse grained samples of cultural transmission, it means that coarse grained analysis of phenomena at larger scales (e.g., community or regional scales) should not focus on fine grained social learning rules, but instead should be built from units which are instances of the converged state.  In other words, regional dynamics (say, visible in comparisons of assemblages or seriation solutions) are built from demes assumed to be at neutral equilibria but in contact.  

This open question is currently being studied via the `ctmixtures` [model](https://github.com/mmadsen/ctmixtures).  


