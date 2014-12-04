---
layout: post
title: Implementing temporal networks in Python, Part 2
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation, temporal network]
categories: 
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriationct
---

### Overview ###

In [Part 1](/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2014/07/28/implementing-temporal-networks-in-python.html) (a few months back), I started making notes about implementing "interval" style temporal networks in Python, using NumPy and NetworkX.  This note continues that thinking, as Carl and I begin serious work on the [SeriationCT](https://github.com/mmadsen/seriationct) for our SAA paper in San Francisco.  

The goal is to use interval temporal networks ("ITN") as a representation for the history of cultural transmission intensity (or "regional transmission model" or "RTM") between a shifting set of nucleated communities in a region, where:

1.  Vertices represent a nucleated community
1.  Vertices have origin times, and may go away during the time interval being modeled.  
1.  Edges between vertices represent a measurable degree of interaction between two communities, whether by trade, simple communication, or residential movement and marriage patterns.  
1.  Edge weights represent a measure of the intensity of that interaction, and can be binary, ordinal, or real valued rates.  

In Part 1, I proposed using NumPy matrices to perform all the comparisons between the graphs representing each subinterval.  This is a sound strategy, both because all the operations are fast given NumPy's matrix code, but because I can rely upon well coded algorithms instead of risk errors in trying to write my own versions directly on top of NetworkX.  

There is a "gotcha" that we have to keep in mind in using the matrix representation:  vertices don't have a unique identifier other than their column and row position.  So deleting a vertex, to represent a community which has exited our model, has to be done carefully.  We cannot, in fact, delete it from the NetworkX object, because that would delete it from the underlying matrix, shifting all the columns and rows **after** that index by one:

```{.python}
import networkx as nx
import numpy as np


t1 = np.array([[1,3,1,1],[3,1,1,1],[1,1,1,1],[1,1,1,1]])
g = nx.to_networkx_graph(t1)
g.add_node(4)
g.add_edge(1,4)
m1 = nx.to_numpy_matrix(g)
g.remove_node(3)
m2 = nx.to_numpy_matrix(g)
``` 

When we look at `m1`, with 5 vertices, we see the following matrix:

```{.python}
[[ 1.  3.  1.  1.  0.]
 [ 3.  1.  1.  1.  1.]
 [ 1.  1.  1.  1.  0.]
 [ 1.  1.  1.  1.  0.]
 [ 0.  1.  0.  0.  0.]]
```

While `m2`, after we delete node 3, is the following:

```{.python}
[[ 1.  3.  1.  0.]
 [ 3.  1.  1.  1.]
 [ 1.  1.  1.  0.]
 [ 0.  1.  0.  0.]]
```

It is always alright to add a vertex to the graph; in the NumPy matrix representation this always results in a new row and column with the index equal to the integer ID of the vertex itself.  It is never alright, however, to actually remove a vertex from the graph.  When we "delete" a community from the regional transmission model, we have to leave the vertex in the graph object, but flip an attribute that we use to track "active" vertices.  Of course, at that point, the vertex participates in no edges, so its column and row in the matrix is all zeros.  We do not simply use this fact to represent "inactive" vertices, however, because an isolated community with no interactions would also show up the same way, should we need to model one in a RTM. 

    

### References Cited ###

