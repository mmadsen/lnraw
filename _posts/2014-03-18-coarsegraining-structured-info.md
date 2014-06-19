---
layout: post
title: Coarse Graining for Structured Information
tags: [coarse graining, structured information, cultural transmission, open problems]
categories: 
- project:coarse grained model
- open problems
---

### Open Problem ###

In the same way that we can coarse-grain a paradigmatic classification by collapsing cells according to a mapping scheme (and then apply that grouping transformation to any occupation number statistics across such mappings), we ought to be able to do the same thing with structured information.

This may be fairly easy if we use the graph or tree representation for structured information, as it turns out.  What we want to preserve are the structural equivalences of sets of vertices in a graph, while producing a coarser graph (i.e., vertices in $G'$ are sets of vertices from an original graph $G$.)  

**NOTE**:  I need to go back and look at what Bergstrom was doing with the map equation and other work with Rosvall.

Xiao et al. [-@xiao2008network] seem to offer a rigorous treatment with symmetry groups and orbits, which is in line with my other uses of orbits and the automorphism group.  They produce the **quotient graph** which has the same structure between orbits, but any intra-orbital redundancy collapsed.  Statistics which work on the orbits as a whole are thus preserved, while others will scale with the reduction.  

This may or may not be a useful way to coarse-grain in a given case, because it implies indistinguishability between vertices sharing the same orbit.  This may be a case for state-space design, to ensure that the state space you start with reflects full symmetries which are appropriate for a coarse-grained description.  

The open problem here, of course, is to show how all this works for a real state-space and how it would affect relative frequencies of "traits," and so on.  

One issue is that you can't do arbitrary nested levels of coarse-graining here -- there's a level of detail and a level of coarse-grained modeling, but not a large level of nested observational levels.  But then, given discussions with Carl Lipo, we don't necessarily see that when we try to do many levels from a paradigmatic classification either.  There may be a couple of useful levels of coarse-graining, and if you want different fine and coarse descriptions, you have to start changing the underlying state-space itself.  


### References Cited ###



