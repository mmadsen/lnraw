---
layout: post
title: Implementing Semantic Axelrod in CTPy
tags: [cultural transmission, structured information, axelrod model, simulation, dissertation,ctpy, SAA 2014, blogarch, experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

This note described implementation notes and questions about using simuPOP and CTPy for the [Semantic Axelrod](/structured information project/2013/07/24/semantic-axelrod.html) model.  

### Semantic Axelrod in simuPOP ###

The Axelrod model has a trait space of $F$ features, each of which can take $q$ states.  This is easily modeled in simuPOP with a standard integer genotype, with `numloci = F` and `k = q`.  

Noise needs some work.  The standard `KAllelesMutator` acts to mutate each locus with the given probability, and what we want in the Axelrod case is to select _one_ locus and give it a random mutation, so that the noise rate is actually a population event rate.  So it looks like a custom mutator will be needed, which selects an individual in the population, selects a feature, and randomizes that feature.  That's easy. 

Since Axelrod is a model which defines "cultures" as spatially cohesive groups of individuals who have no incentive to change their cultural repertoire (either because of consensus or a frozen disordered state), we need a population structure.  The original model was studied on a lattice, but the model can easily be implemented on any graph.  So a big part of the implementation time will be putting simuPOP individuals on a graph.  Surely this has been previously done, so the first step is to start looking for examples.  

The heart of the Axelrod implementation lies in a custom mating function, which:

1. Selects an individual in the population, and a random neighbor for the focal individual.  
2. Assesses homophily given the rules or a threshold value for the pair,
3. Given suitable compatibility, copies a feature state between individuals in the pair.  

### Observables ###

The tough part is crafting suitable observables inside a simuPOP environment, since the system is mostly set up to do population statistics.  We can easily have simuPOP do "subpopulation" statistical counts automatically, but we need to have a way to automatically code individuals as belonging to a subpopulation based upon their cultural genotype so we can do so.  

Axelrod defines individuals as sharing the same "culture" if they have the same states for all cultural features.  This is easy to determine, simply by doing a hash of the genotype, and giving individuals either a subpopulation code or a custom attribute based on this.  The statistics of subpouplations or that custom attribute would then reflect the statistics of groups sharing exact genotypes.  

Spatial pattern might be a bit harder.  Need to think about that.  

