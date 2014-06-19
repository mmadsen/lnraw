---
layout: post
title: Original Axelrod to Semantic Axelrod model - implementation notes
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod, blogarch]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Axelrod Model ###

Currently, I've got a good framework for Axelrod-style models of cultural influence and homophily.  The code is available on Github as [axelrod-ct](https://github.com/mmadsen/axelrod-ct).  The framework stores simulation run statistics in a MongoDB database instance, and has a single simulation running and a parallel batch runner.  The code is a generic evolution of the [CTPy](https://github.com/mmadsen/ctpy) but without the dependency upon `simuPOP`.  

### Adding Semantic Models ###

The next tasks revolve around the "trait model" we use, giving traits relational structure, and any modifications to the Axelrod rules themselves to accomodate these structural changes.  Specifically, I think the steps involve:

1.  Allow the definition of the features to be "extensible" for individuals.  In other words, `F` features might be present, but the initial configuration of individuals will be random and possibly less than `F`.  Individuals might gain new features by copying, but overlap will still initially calculated in a "traditional" manner.  
1.  Add statistics for the "size" of an individual's feature list.  The resulting model will be a useful "neutral" bridge where copying is unbiased+homophily but no structure to the traits themselves.  
1.  Add structure to the traits themselves, in the form of a directed graph, and rules by which copying is possible given the presence of upstream prerequisites.  


### Extensible Trait Lists ###

Most cultural transmission models have followed the "loci and alleles" paradigm, where there is a fixed set of features (loci), which can have a limited or (practically speaking) unlimited number of alleles.  The simplest models, of course, have one feature/locus, and two possible traits.  

Some CT models don't follow this pattern, and allow the accumulation of information over time.  This is what we want to model because in addition to population size and demographic structure, the growth of cultural knowledge (i.e., growth in `F` over time per person) is a key ingredient in long-term enrichment of the cultural endowment of human populations.  So it's essential to model unfixed `F`.  

This means that copying rules can no longer be easily written as "pick a feature, copy the target agent's trait" -- which is how most CT models are written, as was the original Axelrod model for homophily.  

### Implementation of Extensible Traits ###

Looking at the existing Axelrod models, there are several operations on/with single traits or sets of traits that I need to reimplement in such a way that two individuals may have different numbers of features, without "locus/allele" structure. 

The following are notes about how each requirement might be implemented with a Set rather than a list of integers.  In the following I do not assume that traits have any specific structure among themselves.  Some will exist as sets of alternatives along a dimension, but I make no assumption about individuals being able to adopt only one of a set of alternatives in this model.  I'm not worrying about initialization here because it doesn't need to be efficient, it just needs to work.  

**Requirements**

1. replace a trait or set of traits with new ones


```python
import random

# assume "agent_traits" is an object of type set()
# this case comes up in drift, for example
t_new = select_random_trait()
t_old = random.choice(agent_traits)
agent_traits.remove(t_old)
agent_traits.add(t_new)
```

2.  initiatize an agent with a random set of traits, perhaps with a random number of traits
3.  generate a unique representation of a set of traits, for stats, and coloring diagrams
4.  calculation of overlap between trait sets

```python
# since the sets can vary in size, the overlap is simply the Jaccard coefficient
# while the probability of interaction is the Jaccard distance

overlap = len(focal.intersection(neighbor)) / len(focal.union(neighbor))
prob = len(focal.symmetric_difference(neighbor)) / len(focal.union(neighbor))

```

5.  find list of traits which differ between two agents

```python
# trick here is that we need two things:  first, the traits in the focal agent which 
# differ with the target agent (set difference), and then we need the target's traits which 
# differ from the focal agent.  We choose a random differing trait in the focal, to replace
# with a random differing trait from the target.  This is true to the spirit of the Axelrod 
# model without requiring a specific set of loci/alleles (features/traits)

focal_uniq = focal.difference(neighbor)
neighbor_uniq = neighbor.difference(focal)
focal_to_replace = random.choice(focal_uniq)
neighbor_to_adopt = random.choice(neighbor_uniq)

```




