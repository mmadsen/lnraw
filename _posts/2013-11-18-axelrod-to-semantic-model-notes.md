---
layout: post
title: Original Axelrod to Semantic Axelrod model - implementation notes
tags: [SAA2014, axelrod model, structured information, cultural transmission, experiments,  experiment-semanticaxelrod]
category: structured information project
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

### Information Structure ###



