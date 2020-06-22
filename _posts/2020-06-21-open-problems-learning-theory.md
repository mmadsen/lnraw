---
layout: post
title: Open Problems in Learning Theory and Cultural Transmission
tags: [learning theory, cultural transmission, evolutionary theory]
categories: 
- open problems
---

In this post, by "learning theory" I really mean "statistical learning theory," rather than what social scientists mean by "social learning".  In machine learning and computer science, a large amount of research is going into creating models of how to "learn from data".  A key lesson from Boyd and Richerson is the interplay between "social" learning (or "cultural transmission") from peers and conspecifics, and "guided variation" or "individual learning".  Across a variety of disciplines, and especially in evolutionary biology, social psychology, economics, and anthropology, there is a large literature on the circumstances that govern when it is advantageous to learn via trial and error in the environment versus imitate peers.  

Leslie Valiant (1984, 2013) built the mathematical framework for understanding the conditions under which a model can "learn" a concept or target from data.  That framework, "probably approximately correct" or "PAC" learning, is the foundation for statistical learning theory, which in turn underpins the "predictive" branch of statistics and machine learning.  In PAC learning, the learner/agent selects a hypothesis (algorithm/model) from among a permissible space of models that has low generalization error (the "approximately correct" part) with high probability (the "probably correct" part).  Valiant (2013) then took a stab at connecting this with evolution in his popular exposition of PAC learning theory, with variable success.

How do we do this right?  Some version of PAC learning is occurring at two scales in the case of cultural evolution:

1.  Developmentally and ontogenetically:  organisms learn from their environment, both in individual learning (which is really probably a combination of what machine learning researchers now call "reinforcement learning" and forming "generative adversarial models" depending upon the mechanism", and social learning, which boil down to mechanisms like imitating peers, teaching by parents, oblique peers (other adults), and age peers.  
1.  Evolutionarily:  Some of the variation "learned" developmentally is then transmitted through social learning to others and thus becomes a cultural lineage.  

The open questions and opportunities for detailed modeling and research abound for someone who knows both research areas.  Open questions include:

1.  Can we recast social learning through imitation and teaching as a "transfer learning" process or a modification of transfer learning?
1.  Can we model an individual learner as having a set of tasks (targets) for learning, who then does a combination of reinforcement learning (guided variation), transfer learning (imitation or teaching), and adversarial learning (for game theoretic strategic targets)?  We need a name for this kind of amalgamated model -- perhaps "facultative learners"?
1.  Can we create a two-level model which incorporates developmental learning and evolutionary learning by having a population of "facultative" learners all aimed at the same set of multiple targets, but then put a genetic algorithm on top to create a population level process which creates evolutionary change over generations?
1.  In creating the population level process, we need a way to "screen off" the details of individual variation and success on individual tasks from "overall fitness".  Is it appropriate to use the framework of "statistical query learning" to model this selection and screening-off process at the population level?  Or something simpler?  
1.  Perhaps SQL (statistical query learning) is how we represent direct bias or success-based learning in selecting the targets for transfer learning?

Why do we go to all this trouble?  

Fundamentally the issue is how we get "thicker" models for social learning, but retain the ability to do statistical modeling with them.  Population genetics models are sort of a dead end for this task.  Statistical learning theory is probably the best way to model the "evo-devo" of cultural transmission, in a stochastic context, with realistic "targets" and variation.  Then we just need to coarse-grain it to the evolutionary scale with a population-level process on top.  

There is a massive amount of work here, but if this approach can be outlined with real exemplars in a couple of studies, there is a new paradigm here, and one supported by a vast amount of real work and available software to work with.


### References Cited ###

