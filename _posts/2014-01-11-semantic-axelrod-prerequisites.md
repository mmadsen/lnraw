---
layout: post
title: Tree Structured Axelrod for Knowledge Prerequisites
tags: [SAA2014, axelrod model, structured information, cultural transmission,dissertation, experiments,  experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Status ###

I think I have the right algorithm now to represent:

* Nearest-neighbor transmission
* Where cultural traits are arranged in strict trees
* Where parents of a trait in a tree represent a "prerequisite" for a trait/concept
* With individual learning of prerequisites an agent lacks, at some rate
* With occasional loss of traits by chance, at some rate
* With the probability of two agents interacting is governed by their similarity (i.e., homophily)

One observation is that I still have not seen any polycultural solutions; this version of the model either converges to a monoculture, or it cycles around and the number of active links is always a significant fraction of the graph.  

Convergence, in fact, requires a very low rate of loss and innovation (and presumably learning rate, but I haven't tweaked that much).  But I'm not sure converged solutions are the only things we can study here.  We certainly study quasi-stationary equilibria with the WFIA, so really we can study snapshots of the population once the process here is well mixed.  

**Proposition**:  if I track the time series of active link percentages, I should be able to see a long-term average for a process which isn't converging, and I could then wait some suitably long time and take a snapshot at some time when the process was within some $\delta$ of its time average.  

### Trait Structure and Population Initialization ###

Currently, the model is initialized with a specific and fully symmetric trait space, represented as $N_t$ balanced trees with branching factor $r$ and depth $h$.  This gives rise to $\sum_{i=0}^{h} r^i$ total nodes in **each** of $N_t$ trait trees.  

Individuals are initialized by giving them a random number of "assignments," taken uniformly between 1 and _maxinittraits_ (often 8 or 16).  Each "assignment" is a random trait **and** that trait's prerequisites in a given trait tree.  In other words, we initialize individuals with some number of rooted paths from the set of trait trees.  

Initial paths are biased twoards the root of the trees, to represent an initial state with "basic" knowledge, and we expect the population to have more "derived" or specialized knowledge over time.  The implementation is to decide how "deep" the initial path go with a _Poisson_ distribution with $\lambda = 0.5$.  

### Copying Algorithm ###

```python
f = getRandomAgent()
n = getRandomNeighborForAgent(f)

if n = f or n.isdisjoint(f) or n.issubset(f):
	exit  # no interaction possible

prob = jaccardIndex(n,f)
if RandomUniform() < prob:
	traits = neighbor.get_differing_traits(agent)
	neighbor_trait = random.choice(traits)

	if f.hasPrerequisitesForTrait(neighbor_trait) == False:
		if RandomUniform() < learning_rate:
			needed_prereq = DeepestRequiredPrerequisiteOf(neighbor_trait)
			f.add(needed_prereq)
	else:  # has prereqs
		f.add_or_replace(neighbor_trait)

# now we look at the whole population and see if there is a 
# random loss or innovation

if RandomUniform() < loss_rate:
	f2 = getRandomAgent()
	loss_trait = random.choice(f2.traits)
	f2.removeTrait(loss_trait)

if RandomUniform() < innovation_rate:
	f3 = getRandomAgent()
	innov_trait = getRandomTraitNotPossessedByAgent(f3.traits)
	trait_and_prereqs = getPrerequisiteChainForTrait(innov_trait)
	f3.addTrait(trait_and_prereqs)
```

### Trait Tree Measures ###

In those instances when the model runs to convergence, the resulting trait trees are considerably "thinned" out in comparison to the starting configuration.  I expect this to be the case -- we begin with the "entire design space" represented and determine how much variation with what structure is retained in the population at quasi-stationary or stationary equilibrium.    

At least in the converged "final" trait trees, the copying algorithm guarantees that "leaf" traits will not be disconnected from the root (this could happen temporarily given the random trait loss rate).  Thus, the final state of a population is one or more "configurations" of trait trees, each of which is unbalanced (but derived from a maximal $(r,h)$ balanced tree).  

Thus, for each trait tree in a configuration, we can examine:

* What fraction of a balanced $(r,h)$ tree remains?  (order)
* What average branching factor and depth does the remaining tree possess?  $(\bar{r},\bar{h})$
* What is the "shape" of resulting tree?

The latter question is most interesting because many different trees will have the same "order," and probably the same $(\bar{r},\bar{h})$.  The symmetries of a graph capture its "shape" up to a chosen set of symmetries.  For example, if we demand that each vertex have the same edges to the same vertices, then we're looking for _isomorphisms_ of the graph.  This is too restrictive, since the vertices here are arbitrary and simply play roles at a given level in the tree.  What we want are the symmetries resulting from _automorphisms_ of the graph:  functions which rearrange the graph but retain adjacency (and thus vertex and edge count).  

Each graph $G$ is associated with an **automorphism group** $\textit{Aut}(G)$, which gives the collection of ways in which the vertices of the graph can be permuted without altering adjacency.  The automorphism groups of different graphs can then be compared to determine if and how their structure differs [@macarthur2008symmetry].  

$\text{P\'{o}lya}$ showed that the automorphism groups of trees are the class of groups which contain symmetric groups and are closed under direct and wreath products of such groups [@godsil2001algebraic].  Brendan MacKay's [`nauty` program](http://pallini.di.uniroma1.it/index.html) can perform the product decomposition of $\textit{Aut}(G)$ for most graphs [@McKay201494].    With limited values of $(r,h)$ for our trees, however, the product decomposition of trees is likely to be less informative than the **orbit** structure of the graph.

The __orbit__ of a vertex $v$ is the set of vertices into which $v$ can be mapped by automorphisms from $\textit{Aut}(G)$.  In other words, orbits partition the vertex set into equivalence classes where vertices can be permuted into exactly the same adjacency relationships.  In a rooted tree like this, we would expect that the *full* trait tree would partition into three orbits:  the root (which has $r$ incident edges), leaves (which have $1$ incident edge), and vertices in the "middle" of the tree, which possess $r+1$ incident edges.  

A thinned tree will have a different degree distribution, and thus a different set of orbit equivalence classes.  The frequency distribution of orbits in a cultural configuration is thus a good abstract measure of the "shape" of a set of trait trees, and is usable in the quasi-stationary context when we do not have a converged trait configuration and are sampling the population over time.

### Software For Measuring Orbit Structure ###

At the moment, I'm investigating Brendan MacKay's `nauty` program, and the computational group theory software `GAP`.  In addition, `Mathematica 9` can do the calculations.  The tough thing with `nauty` is its reliance on the `Graph6` file format, for which I'm not seeing a good converter from other formats (`networkx` can read it, but not write it).  `Graph6` is incredibly opaque and it's not clear how to write an arbitrary graph in it (it seems designed to compactly represent standard graphs like the Petersen graph, etc).  

So I either need a converter chain, or I need to do the orbit analysis in Mathematica in a loop, reading trait graphs and then writing the results to a file, or learn enough GAP to write a program and save the results. 

Oh, there's also `bliss`, which reads the `DIMACS` format, and also does orbit calculations.  `Conauto` may also output orbits in addition to testing for isomorphism and calculating the automorphism group.  

[links](http://pallini.di.uniroma1.it/Links.html) 


### References Cited ###


