---
layout: post
title: The Semantic Axelrod Model
tags: [SAA2014, blogarch, cultural transmission, structured information,dissertation, axelrod model, experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Background ###

Micro-scale descriptions of cultural transmission are those which examine the population consequences of microscopic (often individual) scale rules or processes (as contrasted to macroscopic models such a reaction-diffusion or diffusion models, see Kandler et al. 2012 -- NEED REF).  Micro-scale models are often implemented as agent-based models, but need not be.  

Micro-scale models are useful despite often being analytically opaque and computationally intensive because they can model emergent properties, and potentially allow causal analysis of how properties at one scale emerge from individual level events.  

That said, there is still considerable diversity in the kinds of phenomena that have been studied using micro-level CT models.  The most common modeling approach has been to treat the frequencies of abstract traits as observables, with copying and mutation rules serving as model analogs for cognitive or psychological processes.  This approach is concerned mainly with how the cognitive processes behind social learning generate distinctive _statistical distributions_ for any and every kind of cultural trait, regardless of what that trait is "about."  I call such models _rule-focused_ micro-scale CT models.  

Rule focused CT models were the obvious place to begin constructing formal models of CT.  Such models mirror the structure of theoretical population genetics, and epidemiology, where the core mathematical models are silent about the content of the "alleles" or "diseases" being transmitted.  

But we quickly run up against limits when we want to ask questions about how cultural evolution leads to why human groups might display certain kinds of substantive features.  Rule-focused models are silent about the content of what is being transmitted, just as population genetic models are silent about what kinds of phenotypes arise from a confluence of modeled "alleles."

What we need, in addition to rule-focused models, are _content-enabled_ models of cultural transmission, which allow us to represent traits that have intrinsic function, meaning, and relationships, and then examine the effect of social learning rules upon their abundance and distribution.  Such models represent an "evolutionary developmental theory" or "evo-devo" for cultural evolution. 

Such models also help bridge the gap between rich narrative descriptions of cultural transmission and technological evolution [e.g., @sterelny2012evolved] and quantitative modeling and data analysis.  This is what my structured information project is about -- constructing the formal and analytical tools to start bridging that gap.  

### Mesoudi Project ###

This is relevant to the Mesoudi invitation, I believe, because the Paleolithic is a time when we see a broad-based trend from relative artifact class uniformity and very large spatiotemporal distributions, to much more regionalized, and specialized, assemblages and toolkits.  The very simplest CT models, such as unbiased/neutral or conformist models -- whatever their virtues -- don't have enough structure to model these trends.  

So.  How simple can a CT model be, and still generate phenomena like those we observe in the long-term Paleolithic record?
  

### Axelrod's Model of Cultural Dissemination ###

Robert Axelrod intoduced a formal model of culture which included social interaction and homophily, and whose behavior displays phase transitions between monoculture (fixation) and frozen domains of different cultural configuration [@axelrod1997]

In the basic Axelrod model, individuals possess $F$ cultural features, with $q$ states per feature, and are arranged on the vertices of a network (commonly, a lattice but other topologies have been studied).  In the continuous time version, pairs of individuals interact at a rate proportional to the number of features they have in common.  In the discrete time version, interaction occurs with a probability defined by the fraction of features they have in common.  During interaction, one individual in a pair copies a feature (at which they currently differ) from the other individual in the pair.  

Interaction in this model tends to make individuals more similar, and interaction is more likely, the more similar people are.  There are two "stable" configuration for a pair of neighbors:  either they share all cultural features  (the same values of $q$ for each feature $F$) or they have different values for every single feature.  In the latter case, the pair of individuals forms part of a "boundary" between two regions of different cultural configuration.  

Starting from a random configuration of traits to individuals, the dynamics lead to one of many absorbing states, which fall into two groups.  In the "monocultural" states or "$q^F$ ordered states", all individuals have the same values of $q$ for all $F$ features.  In the "polycultural" states, the population is frozen into clusters of individuals which share the same cultural traits, but which differ from other such clusters.  In polycultural states, interesting observables are the number and size distribution of clusters.  

Which type of absorbing state is reached depends upon the values of $F$ and $q$, and the degree distribution of neighbor connections also affects the level of disorder in the system.  
 

### The Semantic Axelrod Model ###

The observables (order parameters) studied to date for Axelrod relate to the number and size distribution of cultural domains, and the presence of monoculture given the configuration of the model.  These variables are useful for examining how simple copying processes in the presence of homophily can lead to cultural differentiation.  

But there are other questions we can ask as well.  If the "features" and "traits" possessed by individuals have semantic relationships between one another, then we can allow a configuration to reach one of its absorbing states, and then look at how the distribution of different kinds of cultural trait or information relationship are affected by homophily and copying.  


#### Task or Occupational Specialization ####

A simple experiment would be to define some feature/states as being "prerequisites" for others.  Homophily should lead to distinct domains of knowledge in which individuals have differing prerequisites, and more specialized traits which build off those prerequisites.  This would be a way to explore how VERY simple cultural transmission rules may result in occupational or functional specialization.  

If the number of cultural features $F$ that an individual can have in their repertoire is not fixed, then we can explore the degree to which people become generalists/specialists in certain features and are members of larger and smaller cultural "domains" differentiated by other, "marker" features.  

#### Richer Knowledge Domains ####

We can also pick a pool of concepts which relate to objects, their construction, and use (doesn't matter what the exact concepts are, we care more about their relations), and put them in the mix.  What we _observe_ is the  evolving distribution of the concept relationships, if clusters of different concepts and relations form, etc.  

We can do this with real concepts and real semantics, using the [ConceptNet5](http://conceptnet5.media.mit.edu/) database.  

We can also do the "prerequisite" question above with ConceptNet.  

### Publications and Venues ###


The initial publication of the Semantic Axelrod model would be in the Mesoudi Project as a chapter, with a specific focus on Paleolithic patterns and implications.  

We would then do a theoretical paper somewhere (possibly not in an archaeological journal), focusing more generally on the dynamics and behavior of Semantic Axelrod for general consumption by the CT and opinion dynamics community.  


### Bibliographic Notes ###

Through 2009, the best summary of work on the Axelrod model is given by Castellano et al. in their review in _Reviews of Modern Physics_ [@castellano2009statistical].  

My bibliography of [Axelrod model references in BibTeX format](/biblio/axelrod-model.bib).

Excellent nonequilibrium model which coevolves social network with the opinion dynamics, showing self-organization into communities:  [@holme2006nonequilibrium].  Can we add semantics to this instead of the plain Axelrod?

### References Cited ###




