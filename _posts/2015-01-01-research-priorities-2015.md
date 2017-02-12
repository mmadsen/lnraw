---
layout: essay
title: Research Priorities for 2015
tags: [research, cultural transmission, coarse graining, seriation]
categories: 
- essays
---


I don't really do "resolutions" at New Year's, but I think it's worthwhile thinking about some of the things I want to know, and want to do.  Here I'm going to focus on the former, because I don't think organizing one's research by to-do lists is a very good way to develop good ideas.  Rather, I like to think about ["open questions"](/openproblems.html).  

At the core of my current work (in collaboration with Carl Lipo) is a simple notion:  **that traditional frequency seriation, an archaeological tool first devised in the early 20th century, is the right tool for bridging coarse-grained data on cultural variants and formal models of mesoscopic structure in cultural transmission and social learning.**

At the end of this post, I'll come back to **why** one should care about this idea. But first, my research priorities:


### Seriation and Temporal Network Models ###

An interval temporal network [describes the state of a network over durations](/project-coarse%20grained%20model/model-seriationct/experiment-experiment-seriationct/2014/07/13/seriationct-temporal-model.html) between times when the connectivity pattern changes.  In contrast to event-based temporal network models [@holme2012temporal], interval networks are a good coarse-grained representation for the intensity of interaction between communities in a regional system.  The "change" events can be a change in intensity of interaction (represented by modifications of edge weight), or changes in the pattern of interaction (represented by modifications of the adjacency matrix) or both.  

Interval temporal networks (ITN) are thus good models for a diachronic representation of prehistoric settlement systems and the interaction patterns between those settlements.  Which makes them a tool for representing the kinds of differential cultural contacts and sharing which Ford, Spier, Kroeber, and others believed underlay the patterns they saw in seriations of ceramic assemblages [@lyman2006measuring].  

In the realm of theory construction, therefore, the main question connecting seriation and cultural transmission models, is the degree to which one can infer the diachronic contact network (represented as an ITN) from a seriation constructed from samples of artifact class frequencies.  

This remains the major theoretical modeling question I'm involved in solving.  One of our [SAA papers in San Francisco this spring](/essays/2014/08/29/saa2015-abstracts.html) is aimed at moving the ball forward on this question, and that paper will form the final paper in my trio of dissertation papers, I believe.  

### Continuity vs. Unimodality Seriation ###

In preparing our IDSS seriation paper, Carl Lipo and I debated whether to include discussion of different criteria for forming seriations.  Unimodality was a **choice**, not a necessity, and given an approach to seriation which is theory-driven rather than based upon common-sensical generalizations, we can choose other criteria.  One such criterion is the smoothness or continuity of frequency changes.  Our software already forms such seriations, but we need to explore the criterion further and its relationship to traditional seriation.  Our feeling is that the combination of the two are useful for helping understand the relationship between time, space, and inheritance/cultural transmission.  

### Relation of Seriation Methods to Cladistics ###

Phylogenetic methods construct hypotheses about the relatedness of assemblages/units/taxa given a set of traits/characters/classes.  They do so by applying a criterion like parsimony (i.e., minimizing the number of state changes), in conjunction with principles that provide an "ordering" to state changes (e.g., outgroups tell us whether states are synapomorphic or symplesiomorphic).  Because they are purely formal and not spatiotemporal, phylogenetic models are very useful at the macroevolutionary level of analysis, but they also work at finer scales.  Seriations are inherently spatiotemporal models of state changes, and are often quantitative rather than qualitative.  It would be very useful to establish a concordance between seriation models and cladistic models, such that we can move between representations and use both to describe evolutionary change.  


### Why? ###

**Why care about linking coarse grained data and mesoscopic models?**

First, because most observational data are not individual-scale.  Sure, all the cool kids are busy watching the details of what you do inside online social networks, but we can't understand human social behavior simply by studying Twitter and Facebook.  And in particular, we cannot understand how human sociality has **changed** over the last several million years, either by studying online social networks, or by conducting contemporary experiments and observations alone.  

The vast majority of the evolutionary history of human sociality and evolution is knowable -- if at all -- only through a fossil and artifactual record which is highly aggregated.  And thus, data collected on that record are necessarily coarse grained, to varying degrees. And most research on the evolution of social learning, and the application of cultural transmission models to past phenomena, never bothers to address this fact when trying to match models to data.

Second, most of the attention in model construction and theory building goes to micro-causal, psychological models of social learning.  Models which describe mechanisms like cognitive biases, homophily, small group strategic interaction, for example.  There is nothing wrong with understanding cultural transmission at this level -- it's absolutely essential, in fact.  

But as we know from the experience of paleobiology and paleontology, there are interesting evolutionary phenomena over larger scales (in space, time, and population) that don't require a detailed account of micro-scale causation, because the causation is in the spatiotemporal organization and interaction of populations and environments.  This is the realm of macroevolution for paleontologists, and the realm of mesoscopic to macroscopic models of cultural evolution for archaeologists and paleoanthropologists.  

Within archaeology, at least, most of the cultural transmission-related work seems to rely upon micro-causal and psychological models (mostly derived from [@BR1985] and their student's work), but virtually all of the data sets that folks apply such models to are aggregated at least across significant amounts of time.  There is some effort underway to address time averaging, but the dominant theme of such work may turn out to be "rectifying" the effects by selecting variables which are less affected by it [e.g., @premo2014cultural]. 

I think there's a different moral to our investigations of time averaging:  that one should not try to directly fit micro-causal models to meso or macro-scale data.  

Hence, the overarching attempt to (a) find good methods of describing change in coarse grained data, and (b) find appropriately scaled theoretical models for those data.  


### References Cited ###



