---
layout: post
title: The Semantic Axelrod Model
tags: [cultural transmission, structured information, axelrod model]
category: structured information project
---

### Axelrod's Model of Cultural Dissemination ###

Robert Axelrod intoduced a formal model of culture which included social interaction and homophily, and whose behavior displays phase transitions between monoculture (fixation) and frozen domains of different cultural configuration [@axelrod1997]

In the basic Axelrod model, individuals possess $F$ cultural features, with $q$ states per feature, and are arranged on the vertices of a network (commonly, a lattice but other topologies have been studied).  In the continuous time version, pairs of individuals interact at a rate proportional to the number of features they have in common.  In the discrete time version, interaction occurs with a probability defined by the fraction of features they have in common.  During interaction, one individual in a pair copies a feature (at which they currently differ) from the other individual in the pair.  

Interaction in this model tends to make individuals more similar, and interaction is more likely, the more similar people are.  There are two "stable" configuration for a pair of neighbors:  either they share all cultural features  (the same values of $q$ for each feature $F$) or they have different values for every single feature.  In the latter case, the pair of individuals forms part of a "boundary" between two regions of different cultural configuration.  

Starting from a random configuration of traits to individuals, the dynamics lead to one of many absorbing states, which fall into two groups.  In the "monocultural" states or "$q^F$ ordered states", all individuals have the same values of $q$ for all $F$ features.  In the "polycultural" states, the population is frozen into clusters of individuals which share the same cultural traits, but which differ from other such clusters.  In polycultural states, interesting observables are the number and size distribution of clusters.  

Which type of absorbing state is reached depends upon the values of $F$ and $q$, and the degree distribution of neighbor connections also affects the level of disorder in the system.  

In general, the Axelrod model has been studied by simulation, although some mean-field and rigorous treatments do exist.    


### Generalizing Axelrod ###


The observables (order parameters) studied to date for Axelrod relate to the number and size distribution of cultural domains, and the presence of monoculture given the configuration of the model.  These variables are useful for examining how simple copying processes in the presence of homophily can lead to cultural differentiation.  

But there are other questions we can ask as well.  If the "features" and "traits" possessed by individuals have semantic relationships between one another, then we can allow a configuration to reach one of its absorbing states, and then look at how the distribution of different kinds of cultural trait or information relationship are affected by homophily and copying.  

### Semantic Axelrod ###


A simple experiment would be to define some feature/states as being "prerequisites" for others.  Homophily should lead to distinct domains of knowledge in which individuals have differing prerequisites, and more specialized traits which build off those prerequisites.  This would be a way to explore how simple cultural transmission rules may result in occupational or functional specialization.  

If the number of cultural features $F$ that an individual can have in their repertoire is not fixed, then we can explore the degree to which people become generalists/specialists in certain features and are members of larger and smaller cultural "domains" differentiated by other, "marker" features.  

With more interesting kinds of semantic relationships -- perhaps using something like ConceptNet, we would model adoption probabilities based on how concepts "fit" together in various ways.  This need not be an "Axelrod" model necessarily, but the Axelrod structure gives us the ability to tune homophily while modeling simple CT, while comparing it to known results from non-semantic, structureless models.  


### References Cited ###








