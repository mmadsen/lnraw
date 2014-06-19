---
layout: post
title: Analysis of Symmetry Metrics for Forests of Balanced Trees
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod, analysis]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Symmetry Metrics for Balanced Tree Forests ###

The goal is to understand how `nauty` output and symmetry metrics behave when we
consider a forest with multiple disconnected trees.  This situation would occur
if we calculated symmetries across the entire set of trait trees when capturing
statistics.

Some statistics, such as orbits, might crosscut trait trees if two trait trees
shared adjacency relationships.  In other situations, I'd expect them to be a
disjoint union of results, and thus the statistics might simply be additive (and
thus needing to be normalized by the number of configured trait trees).  In
other cases, such as $|\textit{Aut}(G)|$, the relationship might be
multiplicative and combinatorial.

I proceed by constructing a union graph of 2 balanced trait trees, then 3 and 4,
and examining how the `nauty` output statistics scale.  Then I look at a
combination of different balanced trees.  In the code sections below, I rely upon the [axelrod-ct simulation model](https://github.com/mmadsen/axelrod-ct) available from my Github repository, Brendan McKay's `nauty` library, and the Python `networkx` module.   

```{.python .numberLines}
    import networkx as nx
    import madsenlab.axelrod.analysis as stats
    import madsenlab.axelrod.utils as utils

    conf = utils.TreeStructuredConfiguration("dummyconf.json")
    conf.branching_factor = 4
    conf.depth_factor = 4

    sym = stats.BalancedTreeAutomorphismStatistics(conf)
    g1 = nx.balanced_tree(4,4)
    g2 = nx.balanced_tree(4,4)

    print sym.calculate_graph_symmetries(g1)

    {'radius': 4, 'orbitcounts': [1, 4, 16, 64, 256], 'remainingdensity': 1.0, 'orbits': 5, 'groupsize': 2.079483819622e+117}

    order_tree = stats.num_nodes_balanced_tree(4,4)
    starting_vertex = order_tree 
    g2A = nx.convert_node_labels_to_integers(g2, first_label = starting_vertex)

    graphs = []
    graphs.append(g1)
    graphs.append(g2A)
```

Below is the output for a forest with two trees with $r=4, h=4$.  We can see
that the orbit number is the same, the multiplicities are simply different
because the members of each orbit in each tree are interchangeable, so each
multiplicity is twice the value in a single tree.  The group size is much larger
than twice, however, but we should expect there to be a multiplicative effect
given that automorphisms scale as $n!$ for the complete graphs $K_n$.


```{.python .numberLines}
    print sym._get_raw_nauty_output(forestd)

    5 orbits; grpsize=8.648505912135e234; 511 gens; 121276 nodes; maxlev=409
    cpu time = 0.38 seconds
     0 341 (2); 1:4 342:345 (8); 5:20 346:361 (32); 21:84 362:425 (128); 85:340
        426:681 (512);

    g3 = nx.balanced_tree(4,4)
    g3a = nx.convert_node_labels_to_integers(g3, first_label=(order_tree * 2))
    graphs.append(g3a)
    forest2 = nx.union_all(graphs)

    f2d = sym._format_graph_as_nauty(forest2)
    print sym._get_raw_nauty_output(f2d)

    5 orbits; grpsize=5.395328432456e352; 767 gens; 256020 nodes; maxlev=613
    cpu time = 1.31 seconds
     0 341 682 (3); 1:4 342:345 683:686 (12); 5:20 346:361 687:702 (48); 21:84
        362:425 703:766 (192); 85:340 426:681 767:1022 (768);
```    

Adding a third balanced tree follows the same pattern.  The only concern is the
scaling of group size.  Adding a fourth tree to give me some data points to work
with.

```{.python .numberLines}
    g4 = nx.balanced_tree(4,4)
    g4a = nx.convert_node_labels_to_integers(g4, first_label=(order_tree * 3))
    graphs.append(g4a)
    forest3 = nx.union_all(graphs)
    f3d = sym._format_graph_as_nauty(forest3)
    print sym._get_raw_nauty_output(f3d)

    5 orbits; grpsize=4.487799270734e470; 1023 gens; 444760 nodes; maxlev=817
    cpu time = 3.10 seconds
     0 341 682 1023 (4); 1:4 342:345 683:686 1024:1027 (16); 5:20 346:361
        687:702 1028:1043 (64); 21:84 362:425 703:766 1044:1107 (256); 85:340
        426:681 767:1022 1108:1363 (1024);
```

The exponent is definitely going up as the power of the number of trees:
${10^{117}}^2 = 10^{234}$, and so on.  But the other values are rising as well,
and not by a simple multiplicative factor (which looked like 2).  It looks like
$n!$.

So, with a forest of identical trees, with n trees, and $s = |\textit{Aut}(g)|$
for each tree, the total automorphism group size for the entire forest is thus
$n! s^n$.  This is true for identical tree copies, but obviously more complex
for non-identical components.  We would not also see orbit multiplicities which
are a simple factor of the base orbit multiplicity, and we'd expect that the
orbit number would not be constant, of course.

This turns out to be a well-known result in graph theory, and applicable to any set of repeated graphs, not just trees.  Frucht [-@frucht1949groups] gave the theorem but no explicit proof.  But it's easy to see why this is true.  Take a graph $G$ with $n$ copies of a connected component, $H$.  For each of the $n$ copies of $H$, there are $s = |\textit{Aut}(H)|$ automorphisms which map vertices _within_ each copy.  Thus there are $s^n$ total automorphisms which perform mappings within a single copy of $H$.  Then, we consider automorphisms between the identical copies, and find that there are $n!$ ways of permuting each automorphism with vertices from the $n$ copies.  The total is thus $n! s^n$.  Another way to think of this is that we are doing the cartesian product of the symmetric group $S_n$ which gives all permutations of $n$ elements, with the direct product of all the copies.  I believe this is called an "external wreath product".  


So how do the orbit numbers etc behave with multiple non-identical components?

```{.python .numberLines}
    gx1 = nx.balanced_tree(3,3)
    nx1 = stats.num_nodes_balanced_tree(3,3)
    gx2 = nx.balanced_tree(4,4)
    gx2a = nx.convert_node_labels_to_integers(gx2, first_label=nx1)

    graphs2 = []
    graphs2.append(gx1)
    graphs2.append(gx2a)
    foresth1 = nx.union_all(graphs2)

    print sym._get_raw_nauty_output(sym._format_graph_as_nauty(foresth1))

    9 orbits; grpsize=2.715950187930e127; 281 gens; 36753 nodes; maxlev=225
    cpu time = 0.06 seconds
     0; 1:3 (3); 4:12 (9); 13:39 (27); 40; 41:44 (4); 45:60 (16); 61:124 (64);
        125:380 (256);
```   

So...since the graph components are different, the orbits are disjoint and restricted to their own component.  The total orbit number is simply the sum of the orbit numbers for the two components, and the orbit multiplicites and vertex membership are obviously restricted to each component (easy to see given the sequential vertex numbering). 

The group size is greater than that of a single tree, but many orders of magnitude smaller than the combined group size of two identical trees.  This likely reflects there being very few automorphisms between trees.  In fact, the total group size is simply the product of the individual components: $s = |\textit{Aut}(G_1)||\textit{Aut}(G_2)|\ldots|\textit{Aut}(G_n)|$.  This means that the automorphism group of non-identical graph components taken together as a single graph with multiple components is the "direct product" of the individual components.  What's missing from the simple direct product is the interaction across components, which I suspect is what makes the above calculation a "wreath product," although I don't fully understand the latter yet.  

### References Cited ###

