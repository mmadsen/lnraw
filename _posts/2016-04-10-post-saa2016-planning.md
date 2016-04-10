---
layout: essay
title: Research Priorities for 2016
tags: [dissertation,research, cultural transmission, coarse graining, seriation]
categories: 
- essays
- project:coarse grained model
---

I am somewhat remiss in discussing research goals for the year, because of some family issues which have taken much of my time.  But I'm on a flight back from Orlando from the Society for American Archaeology annual meetings, and I've accumulated notes and ideas over the last three days about where my research stands and what my next steps are.  I also want to evaluate how I did 
in addressing the [priorities I set for 2015](/essays/2015/01/01/research-priorities-2015.html).  

Overall, I got a lot more research done than expected given other responsibilities, but a lot less writing, which I suppose is to be expected.  I was able to tuck bits of work in between caregiving duties, while it's much harder to find blocks of time where I can write, with all of the necessary materials at hand.  That remains a challenge this year, and one I need to fix since my time will be impacted on an ongoing basis.  

I started the year understanding the nature of the final conceptual bits of my project to infer metapopulation structure (in terms of cultural transmission patterns) from diachronic seriation solutions, and at this point (early April 2016), the concepts and connections are firming rapidly into an analytic method and a set of applications.  That feels really good.  I've given an exploratory talk about this in [Binghamton recently in my EVoS seminar](/essays/2016/03/22/evos-seminar-series-binghamton.html), and a larger sample of models and more sophisticated analysis will be the subject of a talk at the [Human Behavior and Evolution Society annual meeting](http://www.hbes.com/hbes2016) in Vancouver in late June.   


### Contents ###

1.  Seriation and temporal network models
1.  Parallel seriationct processing completed
1.  Network models for seriationct finalization
1.  Likelihood of empirical seriation WRT models
1.  Seriation of additional data sets
1.  Relation between seriation and cladistics
1.  Continuity HBES paper
1.  SeriationCT HBES paper
1.  Future questions


### Seriation and Temporal Network Models ###

The basic question I'm addressing is __whether we can use diachronic seriation solutions, which map trait similarity across both space and time, to infer something of the topology of the temporal network formed (conceptually) by the changing interaction strength between past communities, where "interaction strength" refers to the intensity with which people migrated between communities or engaged in social learning with individuals outside their local subpopulation.__

In prototype, the answer appears to be __YES__.  Metapopulation interaction structures that have significantly different topologies for weighted edges in an _interval temporal network_ display different seriation structures, measured as the Laplacian eigenvalues of the seriation expressed as a graph (as we do in our IDSS software).  I am testing differentiation of interaction network classes using a standard, high quality machine learning classification algorithm (e.g., gradient boosted trees or random forests).  

There is much unfinished business turning my early results into a solid body of scientific results and a general method.  The next two priorities cover the "big" tasks, but I would be remiss if I didn't mention the important element of ensuring that I am sampling and seriating over randomized instances of interaction network models, not just Monte Carlo samples of time averaged cultural transmission.  Some networks have very little scope for randomization, such as the "panmictic" case where interaction is represented as a uniformly weighted complete temporal network (i.e., where the network at any point in time is $K_n$).  Some randomization related to community/assemblage duration could be modeled by randomizing the choices of number of slices and total simulation length, and that probably needs to be done.  

I should also mention that randomization of the network model involved fully rewriting the post-simulation processing chain, such that we pass and use the correct network model to every step of the chain, and can associate parameters and info from each stage of the processing chain to downstream elements for analysis.  That work is nearly complete (15 April target).  

The two weightier methodological issues are discussed in their own sections.  Once complete, the main computational task is to develop a reference library of simulated seriations resulting from the chosen suite of network models, across priors for both network parameters and CT simulation parameters.  

### Network Models for SeriationCT ###

Right now I have the following interaction network models:

1.  Lineage splitting or coalescence
1.  Complete network/panmixis
1.  Approximate nearest neighbor interaction

This set has not been chosen because it represents the "right" set of models for any specific empirical case, but because I was developing ways of representing various topological characteristics (e.g., distance-respecting interaction, distance-insensitive interaction, large-scale splits in interaction or coalescence).  It's apparent to me that there are really two levels of topological features we might be able to examine:

1.  Mesoscale connection variability:  sparseness, evenness of interaction, and the decay of interaction with distance all speak to mesoscale connectivity
1.  Macroscale history:  the history of lineage splitting and coalescence events which give us the structure we see at very large historical scales

In a mature inference method, we need an ABC reference library of seriations that includes a good spectrum of mesoscale options, expressed in whatever set of macroscale options seem most likely given our gross-scale culture-historical knowledge or previous research.

Thus, I am going to work on finalizing graph builders that incorporate:

1.  Panmixis
1.  Nearest neighbor interaction with tunable small world links
1.  Hierarchical (2- and 3-tier) nearest neighbor interaction with tunable small world links

Each of these graph builders should then have the ability, ultimately, to also implement a lineage split or coalescence "on top" of that mesoscale connectivity pattern.  


### Likelihood of Empirical Seriations ###

Given a reference table of seriations (seriation graph Laplacian eigenvalues, more precisely), a classifier model will always give me an answer as to which interaction model a seriation belongs to.  So it's really the full ABC inference loop that will help us figure out which of the models might be "least wrong," with the possibility that none are very close always open.  I have explored the Euclidean distance/L2 loss between the empirical seriation and the eigenvalue spectra of reference table data points, and that will be the first criterion used, although I want to fully explore Pudlo and Robert's [-@pudlo2014abc] suggestion that a two step random forest analysis could perform better than simpler rejection or threshold methods in this situation.  

### Relation Between Seriation and Cladistics ###

This is really just a downpayment on a note, but I talked with Carl Lipo a great deal this weekend about an idea I've been developing, that cladistics and seriation are really separated by a "level" (sensu Dunnell [-@Dunnell1971]) distinction.  Frequency seriation, whatever the ordering algorithm, takes advantage of __trait polymorphism__ in the population to make ordering decisions, whereas standard phylogenetic methods tend towards presence/absence of binary or multivalued variables.  Thus, phylogenetics operates at a coarser level of analysis (but not scale!) and makes coarser distinctions.  

Of course, there is a small literature on polymorphic characters in seriation, but it seems to die out and there are no packages I know of that use character frequencies in tree construction.  If there were, those methods would be comparable to frequency seriation.

So really, various types of occurrence or character-state seriation are comparable to cladistics, as "macroevolutionary" methods, and frequency seriation is "mesoevolutionary" at a finer level of analysis.  

There's also some good stuff to discuss in terms of synapomorphies in material culture, but that will have to wait since my flight is going below 10,000 feet....


### Continuity HBES Paper ###

We have a start on the continuity paper already, from SAA's.  The point of the empirical example in it right now is simply to show that we get the same answers when we examine frequency data with unimodality as the ordering criterion, compared to exact distance minimization.  I think perhaps the point needs to shift to demonstrating how we can do much larger data sets with continuity seriation, which is crucial for truly understanding macroevolutionary patterning, while retaining the information about polymorphism that seriation employs (and cladistics generally does not, see previous section).  This would be a good place to try to look at the LMV as a whole, adding Mainfort, PFG/Lipo, and anything else we have with enough sample size (it would be good, for example, to incorporate data from Greg Fox's dissertation, from slightly further north in SE Missouri), and even look to seek if there are any data that would connect us up towards Cahokia.  

### SeriationCT HBES Paper ###

The goal is to actually give several empirical demonstrations, with brief descriptions of what interaction pattern (or patterns) are believed to hold in each case, and walk through the analysis to describe how it's done, and show answers for 1-3 data sets.  This might be two chunks of Mississippian that have different local interaction patterns, and the Woodland data.  I need to think more carefully about the difference between interaction expectations for Woodland vs. Late Prehistoric, since the dispersed vs nucleated issue will bear on what suite of models we examine for each.  I may not be at a point where I can develop the reference library of seriation data for Woodland dispersed communities yet, and perhaps I need to focus on 1-3 different late expressions.  



### Future Questions ###

These are questions which arise when we describe the regional structure of social learning and cultural transmission using interval temporal networks as the representation for mesoscale relationships, and employ seriation graphs and their statistics as the data to infer the class of ITN.  

1.  What effect does the mean duration of assemblages (compared to the total span of time) have on our ability to accurately classify seriations as to network model?
1.  How does classification accuracy scale with the number of assemblages available, and the scheme by which they were sampled?  (some of this may be anecdotally necessary to look at PFG, but a systematic computational analysis of the scaling can wait).  
1.  How does assemblage sample size in concert with innovation rates affect classification accuracy?   






