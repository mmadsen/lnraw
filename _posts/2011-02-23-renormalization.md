---
layout: post
title: Renormalization and Archaeological Applications
tags: [cultural transmission, coarse graining, renormalization]
categories: 
- project:coarse grained model
- reading notes
---



## Relevance to Archaeology ##

If there ever was a social science that needed an explicit body of methods for scaling individual-level social theory to large-scale patterns, it's archaeology.  Archaeologists are continually attempting to formulate and use individual-level models of social processes.  Whether this is foraging theory, game theory, evolutionary theory, or something more nebulous, we are borrowers of microscopic theory from other social and natural sciences.  

But our empirical record is not even remotely reflective of the scale at which those microscopic social processes act.  We observe a macroscopic record whose "characteristic scale" is many times the time scale of the social processes we use as explanations, and aggregating together many events that are the result of many people.  

We also observe that record using analytical classifications and variables which are chosen for convenience and have no systematic or provable relationship to any hypothetical "units" in the past.  

## Basic Concept ##

If we strip away all of the terminology which is specific to renormalization problems in specific theoretical realms (e.g., QFT or condensed matter physics), the principle is simple:

>Renormalization is the formal analysis of how to describe a system's dynamics, through a measurement process, at different scales of observation.

Two things are important here:

1.  The way we observe a system normally needs to be part of our model of the system.  
1.  The "scale" of our observational methods determines aspects of the quantitative relationships we will measure about a system.  

The first point has been central to physical theory since the development of quantum theory, but is relevant to all systems.  It's just that when we talk about systems described at a single scale that is the same as our measurement scale, and when the measurement process does not perturb the measured system, we can usually "factor out" the details of measurement.  

The second point is less well understood, but is pretty much a consequence of the first.  Our measurement processes operate at "characteristic scales," and typically there is some kind of "cutoff scale" at which we cannot observe details that are smaller, faster, or higher in frequency.  But our inability to measure or observe those details doesn't mean they don't influence or even determine the dynamics at larger scales, so we need to account or them somehow, not just ignore them.

Renormalization is the process of "integrating out" the effects of physics below a cutoff scale.  To use an example from Susskind, if we're trying to describe physics at the scale of atoms and molecules, we're not concerned with the details of how quarks form nucleons.  And if we're interested in the properties of a volume of liquid, we're not terribly interested in how electrons and nucleons are put together to form atoms.  

It turns out that we can't simply *ignore* the effect of the smaller/faster scales, however.  We need, instead, to understand how to *scale* our understanding of the dynamics at a given level to our observational methods, averaging over all the stuff below the cutoff. 

## Basic Process ##

The goal is to integrate out the fast and small degrees of freedom, and use a "mean-field" type approximation for all the fast/small stuff as the basis for a dynamical description of the whole at a higher level (see above).

In practice this mean:

1.  Separate scales
1.  Separate processes
1.  Summarize scales and processes occurring fast & small
1.  Rewrite the description of the entire system using the summarized description of fast/small dynamics instead of the detailed contributions of fast/small entities
1.  Find new high level observables for this renormalized description


### Separate Scales ###

This is primarily time scales, but it's also distance scales.  So, basically in our case, it's separation of spatiotemporal scales.  

As a prime example, assume we are investigating regional variation in ceramic assemblages, with assemblages representing chunks of time from residential communities (e.g., late prehistoric nucleated villages).  

The resolution of our observations is necessarily coarse-grained in such cases:  the frequencies of analytical classes for each assemblage, which is equivalent to treating the **average** frequency of each class as constant over the duration of the assemblage (in the absence of data about artifact accumulation rates by artifact class).  

Given this level of observational resolution:

1.  We probably cannot meaningfully differentiate models and hypotheses which describe individual-level variation, unless those theories display strong phase transitions whose character is distinguishable at macro scales.  _Whether a process model does have a sharp phase transition which can be distinguished at longer, averaged scales, is something that must be investigated for each process model.  No generic answer is possible._
1.  We need an "averaged" description of possible lower level transmission models, weighted by their frequency or prevalence, to drive the higher level description.  

### Separate Processes ###

This is related to separating scales, actually.  Think about Susskind's example of the two atoms interacting.  Ideally the Hamiltonian is composed of a sum of terms, referring to the effects of different processes or components, and we can make a decision about whether a given process is part of the "fast" or "slow" stuff, and renormalize it out accordingly.  

So the point here is simply that we have to watch our theory-building carefully and try not to have terms in the Hamiltonian which combine fast and slow things into the same term, this can make it hard to renormalize (I'm pretty sure, I'm inferring that given what I know at this stage of the game).  


