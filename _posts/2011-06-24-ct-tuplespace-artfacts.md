---
layout: essay
title: CT Models Incorporating Artifacts and the Record Via Tuple Spaces
tags: [transmissionframework, simulation, niche construction, tuplespace models, open problems]
categories:
- project:niche construction
- essays
- open problems
---

The basic idea here:  we cannot model cultural transmission, as it is really implemented in humans, by acting like traits are alleles at genetic loci.  Such models were important, because they gave us a _modeling framework_ within which we can analyze CT models, but neutral Wright-Fisher or the SIS/contact model are not CT.  

The simplest reason why we cannot simply use WF/SIS and variants to accurately model culture is, (1) that such models treat culture as if everybody had "variants" of, and when people acquire a new variant, they get rid of their old one (i.e., some form of detailed balance holds), and (2) that such models assume that the cultural repertoire is held as "live" variants in individuals, like the genetic repertoire, and thus inventorying the population will give you a variant per individual, period, while the real situation is that people can hold multiple variants or have "mixed strategies" over a spectrum of traits, and we can also store traits outside our bodies, in the form of artifacts.  

Fixing #1 must be done carefully, since giving up detailed balance gives us stochastic models which are much harder to analyze, since they often have no stationary distribution and frequently are non-ergodic.  It means we'll mostly understand models which relax detailed balance in certain cases where we can directly solve the relevant master equations, or that we'll mostly understand such models through simulation.  

Fixing #2 can be done by incorporating a reservoir of objects outside the state space of individuals holding their own traits, and incorporating a rule whereby individuals occasionally copy each other directly, occasionally copy some object they observe, and occasionally innovating on their own traits, or innovating off an object used as a model.  

This would seem to cover a 2x2 matrix of possible interactions between individuals, objects, and traits.  If one reduces the number of objects to zero, and assuming a "detailed balance" model for trait kinetics, then we are back to a standard genetic model like WF or Moran.  

But we can alter the mix of the various rules by altering their rates, so we have a phase space including each as dimensions.  

This can be implemented by using a Population and an ArtifactSpace, with the latter implemented as a tuple space.  

An artifact would be made, by an individual, at some rate, out of a combination of traits held by that individual, and placed in the tuplespace.

Initially, artifacts would have a single average use-life, before they expire out of the tuplespace.  Artifacts don't live forever.

Artifacts would be represented in the tuplespace by variables:

Traits:  list
Creator:  agentID

We might have rules, for example, that allow individuals to query their own artifacts out of tuplespace, and copy them, or perhaps to query everybody else's artifacts, or neighbor's artifacts.  This would allow adjustment of rules about copying.  

We need three sets of observables:  stats on traits held by individuals, traits in artifacts, and the combination of both.  



