---
layout: post
title: The Semantic Axelrod Model
tags: [cultural transmission, structured information, axelrod model]
category: structured information project
---

### Background ###

The most common way to describe different approaches to the study of cultural transmission is to examine lineages of researchers and the disciplinary influences that result in differences in models or research questions.  Another approach focuses upon the mathematical structure of models themselves, showing (for example) how neutral population genetic models share the same structure as the SIS model in epidemiology, and how both are examples of the contact process from mathematical probability theory.[^1]  

Another way to understand the diversity of CT models and approaches is to look at the nature of the observable variables from the models we study. I propose that existing formal models differ in whether they 


### Background ###

"Cultural transmission" modeling is divided into a couple of main traditions, that differ mainly in the kinds of questions being asked. The tradition represented by Boyd and Richerson and derived from a mixture of theoretical population genetics and epidemiological modeling, tends to focus on the _statistical distribution of the content of CT given a mixture of processes_.  

The tradition of "opinion dynamics," tend to be physically derived (e.g., from Ising and Potts models) and have been mainly studied by economists and physicists working on complex systems.  The major questions in opinion dynamics models have been, what factors influence the development of consensus versus disagreement, when does a population break up into islands of differing culture or opinion, and what are the statistical properties of such islands of agreement when they form?  

I'd argue that these modeling traditions are complementary.  Archaeologists usually need to ask questions about the distribution of the _content_ resulting from CT processes, but the models derived from the population genetic tradition make it difficult to address population structure and differentiation, in a macroevolutionary context.  This is mainly driven by the "equilibrium" nature of models derived from population genetics. 

I'm hoping that we can combine the nonequilibrium study of models like the Axelrod model of opinion/cultural dynamics, with a focus on the _content_ of cultural information being transmitted, and improve our understanding of how the fission and differentiation of cultural groups also influences the content and _history_ of material culture itself.  

This is a tall order because in nearly every model of CT in existence, the information or traits being transmitted are simple markers or tokens, and bear no "meaning" themselves -- no "content" for us to study other than counting frequencies and looking at the shapes of distributions.  In this project, I propose to augment the Axelrod model with semantically meaningful traits, and observe the effects of cultural differentiation and consensus on the distribution of _meanings_ and _semantic relationships_ within and across populations.  

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




[^1]:  Another good example is the ability to map the Axelrod model of cultural differentiation discussed here, 
	to the q-state Potts model, which has rich connections to other spin models in statistical physics.  





