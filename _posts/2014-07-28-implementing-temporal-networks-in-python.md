---
layout: post
title: Implementing temporal networks in Python
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation, temporal network]
categories: 
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriationct
---

### Overview ###

The goal here is to prototype a smooth and efficient way of evolving a `NetworkX` graph object, given a more compact specification of a "interval" temporal network, as discussed in [Temporal Networks in SeriationCT](/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2014/07/13/seriationct-temporal-model.html).  

In the following, I assume either that a compact configuration, or a random network generating process (NGP), produces a sequence of `numpy` matrices which are indexed by a time coordinate.  The task, then, is to examine differences in the sequence of matrices, and produce corresponding changes to a `NetworkX` graph object, without simply destroying and reformulating the graph object.  

The latter requirement is important because each vertex in the graph object will also be a container, holding a subpopulation of agents which are engaged in social learning.  Vertices will thus represent demes of individuals, and our observable samples in the `seriationct` model will be derived as time-averaged samples of traits from each vertex.  


### Prototyping ###

For simplicity, I start with the complete graph $C4$ on four vertices, with one link having a link weight

```{.python}
    import numpy as np
    import networkx as nx
    import matplotlib.pyplot as plt

    # start with C4, the complete graph on four vertices, with uniform weights
    t1 = np.array([[1,3,1,1],[3,1,1,1],[1,1,1,1],[1,1,1,1]])

    g = nx.to_networkx_graph(t1)
```

At step 2, we imagine that two links are lost, indicated by their weight going to zero in the adjacency matrix.  


```{.python}
    # step 1 - loss of two links
    t2 = np.array([[1,0,1,1],[0,1,1,1],[1,1,1,0],[1,1,0,1]])

    g2 = nx.to_networkx_graph(t2)
```

We can tell which edges change by looking at the nonzero elements of the upper triangular portion of the **difference** of the two matrices:

```{.python}
    t2 - t1

    # array([[ 0, -3,  0,  0],
    #       [-3,  0,  0,  0],
    #       [ 0,  0,  0, -1],
    #       [ 0,  0, -1,  0]])

    np.nonzero(np.triu(t2 - t1))

    # (array([0, 2]), array([1, 3]))

    changed = t2 - t1
    changed_edges = np.nonzero(np.triu(changed))
    # (array([0, 2]), array([1, 3]))
```

`changed_edges` reports those elements which are different between the two matrices, in the upper triangular portion of the matrix.  We are mainly interested in off-diagonal elements at the moment.  The data structure is a tuple composed of two lists, the row and then the column coordinates.  This unusual structure is the reason for the use of `zip` in the enumeration below.  

Weight changes to existing edges are simply the difference between the two matrix elements, already reflected in the `changed` matrix entry, and we can detect edges that go away entirely by a weight change which complete offsets the `t1` weight at `t2`.  If an edge goes away, we remove it.  If the weight changes, we alter the weight property for the edge

```{.python}
    for i,j in zip(changed_edges[0], changed_edges[1]):
        weight_delta = changed[i,j]
        removed = False if t1[i,j] + changed[i,j] else True
        print "changed edge at %s,%s - weight delta: %s remove? %s" % (i,j, weight_delta, removed)
        if removed:
            g.remove_edge(i,j)
        else:
        	g[i][j]['weight'] += weight_delta

    # changed edge at 0,1 - weight delta: -3 remove? True
    # changed edge at 2,3 - weight delta: -1 remove? True
```



    

### References Cited ###

