---
layout: post
title: Open Problems in Coarse Grained CT Theory
tags: [coarse graining, cultural transmission, synchronization theory, open problems]
categories: 
- project:coarse grained model
- open problems
---

### Convergence and Basins of Attraction ###

We can often identify detailed social learning rules through their frequency characteristics in "pure populations" of such learners, and in experimental situations.  In heterogeneous populations, where individuals display a mixture of social learning rules, I expect that it will be difficult to do so from bulk or CG samples of the population as a whole.  This will even be true for partitions of the population (e.g., spatial aggregates) unless social learning rules are assortative with respect to population partitions.  

Thus, I expect that combinations of fine grained models will converge to some "averaged" state.  Questions include:

1.  Is this averaged state equivalent to a population in which copying is unbiased and random (i.e., the neutral model, an Ising model with no external field, etc)?
1.  What is the relaxation time to convergence?  If the convergence time is fast, especially in the small populations we deal with, then we wuld always expect populations to appear to be converged, and we would never see far-from-equilibrium states that "look like" other social learning rules.  
1.  Are there social learning rules which are outside the basin of attraction of this convergence?  In other words, can we detect some rules but not others?

If there is a strong warrant for a convergence structure to coarse grained samples of cultural transmission, it means that coarse grained analysis of phenomena at larger scales (e.g., community or regional scales) should not focus on fine grained social learning rules, but instead should be built from units which are instances of the converged state.  In other words, regional dynamics (say, visible in comparisons of assemblages or seriation solutions) are built from demes assumed to be at neutral equilibria but in contact.  

This open question is currently being studied via the `ctmixtures` [model](https://github.com/mmadsen/ctmixtures).  Older notes related to convergence:

* [2 Oct 2012](/coarse%20grained%20model%20project/2012/10/02/coarse-graining-history-ctmodels.html)
* [31 March 2013](/essays/2013/03/31/darwinian-populational-models.html)


### Regional Scale Transmission Phenomena

If most (or all) fine grained models converge to a neutral diffusion process, what can we learn at coarse scales by fitting models?  We will not be able to identify which fine grained social learning rules characterized the populations who left the remains we're studying.  It may be possible to infer something about relative rates of innovation, although since we lack reliable information about population size, the jury is still out on this (not that we can't study innovation, it's simply not clear how we can reliably say sample X is characterized by a higher rate of innovation than Y).  

In some respects, taking samples with significant durations (and thereby generating time and population averaging effects) is beneficial to model construction because it creates a clear separation of time scales.  Individual-scale transmission events, described by fine grained social learning models, aggregate sufficiently that we can treat them as equilibrium phenomena, particularly if the convergence conjecture turns out to be correct.  These _fast_ degrees of freedom are contrasted by _slow_ degrees of freedom which characterize the aggregate of connections between past communities.  

The slow degrees of freedom are decidedly _not_ at equilibrium, but instead are "far from equilibrium" phenomena and display _history_.  The presence of particular (neutral) traits in particular areas (but not others) is path dependent.  Note that were the slow degrees of freedom at (or near) equilibrium, this would imply a randomization of the distribution of the phenomena they describe (e.g., trait distributions).  With traits which are not neutral in their effects, then it is not merely interaction history but technology and environment which determine their historical distributions.

The first conjecture is that we can construct a model with pieces -- local subpopulations which are at equilibrium for a converged model, and that varying the strength and pattern of connectivity between them will generate a unique history of trait frequency patterns in space and time, similar to what archaeologists confront in regional assemblages of, say, ceramics.  

The second conjecture is that we can infer this connectivity pattern from _samples_ derived from the demes, with a set of increasingly strict conditions:

1.  With a sample of the demes, but where each demic sample is a random sample over the entire duration of the deme's existence, and the trait frequency distribution is accurate (i.e., it is not missing rare traits, or the oldest material has not suffered differential post-depositional attrition).
1.  With a sample of the demes, where the samples represent the entire duration, but there is loss of very rare traits given sampling.
1.  With a sample of the demes, where there is loss of rare traits due to sampling, and where the sample is a subinterval of the full demic duration.

These conjectures do not cover all archaeological cases, of course, but they go some distance towards turning very abstract models into theories that tell us about the actual archaeological record.  

This open question is currently part of my dissertation research, and will be modeled in [seriationct](https://github.com/mmadsen/seriationct). 

### Synchronization Theory and Regional Scale CT

We do not identify sets of assemblages as having been interacting because they share the same traits at the same time.  Ever since Spier, Nelson, Kroeber, and later James Ford, we identify such interaction by the fact that assemblages share _some_ traits and that these tend to change in similar ways, even if at different times.  We expect lags and delays, but similarity in patterns of change.  

This sounds an awful lot like the phenomenon of _synchronization_, in which a group of individual entities who are weakly coupled in some way fall into "phase" and begin changing in similar ways.  All of the classic and simple examples -- fireflies, or clocks next to one another -- are described by "limit cycle" oscillators, whose activity become entrained in time and thus can be described by periodic functions with a "phase" variable.  The classic model here is the Kuramoto oscillator.

But many phenomena can be synchronized, even if they do not easily admit to description as coupled oscillators (or if we have not yet found that description), and even if the phases are not synchronous but involve various lags and delays.  An important example here is synchronization of measles outbreaks, both in-phase and anti-phase, driven by the pattern of mobility of infected individuals between locations.  

This example alone tells me that there is a useful description of regional scale CT in terms of delay- or lag-coupled synchronization.  Communities come into synchronization when they begin sharing enough traits (through transient contact or permanent migration) that their trait profiles begin having many of the same traits and moving in similar directions quantitatively.  Communities desynchronize when their communication and sharing falls below some threshold relative to the _other_ communities with whom they share.  

Furthermore, I conjecture that **samples can form a seriation solution precisely when they are possess in-phase synchronization**.  When we adopt the strict definition, and judge the ability to put a set of assemblages together into a seriation, the ability to do so indicates that they are in relative synchronization.  The inability to do so indicates desynchronization or lack of sync.  
What good is connecting seriation and regional analysis to synchronization theory?  In some sense, lag-coupled synchronization actually _explains_ why the traditional "rules" of seriation (e.g., same cultural tradition, uniform duration and limited spatial extent) work the way they do in combination with cultural transmission processes.  That's good and useful, but it doesn't directly lead to new results.  

The hope is that phrasing the problem in the language of synchronization models will yield new observables that would allow us to differentiate classes of inter-community organization, in ways that straight seriations do not.  

For example, under what conditions is the synchronized state **stable**?  In the language of seriation, what patterns of interaction cause samples from a region whose populations formerly seriated together to no longer fit together into a single seriation solution?  A key might be the "master stability function" studied by Barahona and Pecora [-@barahona2002synchronization].  

Similarly, the onset of synchronization is increasingly well studied, especially on different network structures.  Arenas and colleagues [-@arenas2008synchronization] review this work up to 2008, summarizing that the onset of synchronization is sensitive to "community structure" (i.e, mesoscopic structure within a network), and that in scale-free (or nearly scale-free) networks, hubs with the largest number of connections may not synchronize with neighbors and may form nodes of their own, despite their power in driving spreading dynamics.  The latter phenomenon may lead to ways of identifying hubs from the way they behave in seriation solutions, which would firm up some of our conjectures in the LMV dataset concerning sites like Parkin, for example.  

### References Cited 
