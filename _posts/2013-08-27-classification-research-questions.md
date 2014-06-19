---

layout: post
title: Classification Experiment Research Questions
tags: [cultural transmission, classification, coarse graining, simulation, ctpy,
dissertation, experiments, experiment-classification]
categories: 
- project:coarse grained model
- model:ctpy
- experiment:experiment-classification

---

### Research Questions ###


At a minimum, what we can observe in the archaeological record about a past CT process are its effects 
upon the richness and diversity of artifact classes, perhaps the rate at which new variants are introduced, 
and how long variants last.  

Class diversity implies the use of an archaeological classification to construct discrete categories of variation
from the continuous variation present in any collection of objects.  Rate observations imply an understanding of 
how our samples are time averaged (which will be the subject of the next experiment, combining classification and 
temporal aggregation).  

Thus, the purpose of the classification experiment is to explore how statistical measures of 
richness and diversity from cultural transmission models "scale" when traits are observed through
classifications of the type employed by archaeologists.  Such classifications are assumed to be coarse with respect to the variation actually transmitted between individuals during transmission, and thus classification is a "coarse-graining" process. 

### Representing Classifications ###

In the underlying CT model (and its instantiation through simulation), transmitted variation is represented as a set of 
dimensions which can take an unbounded number of values.  In other words, I employ the standard "alleles at loci" representation
from population genetics, interpreting loci as generic dimensions of cultural variability (e.g., pottery surface treatment, or vessel rim thickness), and alleles as either discrete or continuous variants for that dimension (e.g., unslipped surface treatment, or a vessel with 5.5mm thick rim).

One limitation with the current study is that I do not represent classifications with arbitrary dimensions, with respect to the loci that evolve under transmission.  It would be desirable in a future study to form the "classification space" as oriented arbitrarily with respect to the transmitted trait space, so that we can study classifications which are wholly arbitrary with respect to the underlying information transmission -- but representing this is a hard problem.  

For the moment, loci correspond to classification dimensions, and what can vary about a classification is the way we "slice" those dimensions of variation into modes or classes for observation.  Again, this is a coarse-graining process, so we might have a continuous dimension of variation, which is sliced into three or four categories for observation.  Or we might lump together discrete variants (e.g., mode of application of surface treatments) which are difficult to distinguish observationally from the resulting sherds but were learned as distinctly different modes of construction by the creators of the ceramic vessels we study.  

All classifications in this experiment are strictly *paradigmatic* [@Dunnell1971].  Future experiments may focus upon hybrids or hierarchical classifications, since these are common when using previously collected data from published sources.  

In the simulation models, classifications are represented as sets of dimensions, having the same dimensionality as a given simulation uses for the number of loci.  Each dimension is then cut into $n$ modes -- this number is the *coarseness* of the dimension.  Furthermore, dimensions can be partitioned into $n$ modes in two ways:  *even* partitions, and *random* partitions.  

Random partitions allow us to examine situations where archaeologists create discrete modes which may cover the underlying variation unevenly, with respect to how it was learned, or with respect to how new variants or copying errors were constructed during transmission.  

Even partitions, on the other hand, should be a pure  "rescaling" of the quantitative relationships at the underlying "trait" level into the classification.  

### Regressions ###

In this simulation experiment, I want to establish the nature of the following scaling relationships.  The ideal result would be an equation for each mapping, or at least a statistical model which describes how to predict each side from the other.   

1.  `Mean Trait richness per dimension` $\leftrightarrow$ `Mean mode richness per dimension`
1. 	Fraction of filled classification space, as coarseness is altered [^1]
1.  `Mean Trait evenness per dimension` $\leftrightarrow$ `Mean mode evenness per dimension`
1.  `Mean Trait evenness across dimensions` $\leftrightarrow$ `Mean class evenness` [^3]
1.  `Mean Trait innovation rate` $\leftrightarrow$ `Mean mode or class innovation rate` [^2]

These relationships are conditioned by variables such as $\theta$, the combination of innovation rate and population size ($2N\mu$).  

I also want to know how the method of breaking a dimension into classification modes (`EVEN` or `RANDOM`) affects the distribution of observable richness and evenness metrics.  The basic analysis here should be to do a curve fit for each observable, at specific mutation rates.  In particular, it'll be interesting to see how wide the confidence envelope around the `RANDOM` classifications is....



[^1]: Since the underlying trait space is infinite (in theory, although the simulated trait space is finite but much larger than will be explored given the length of the simulation run and innovation rate), it's difficult to talk about how much "volume" is occupied in the trait space.  But there should be a measure here, since statistical physics has the same problem talking about volumes in phase space.  

[^2]: The mean trait innovation rate is actually a *parameter* for each simulation run, and does not need to be measured.  But the mean rate at which novel *modes* or *classes* appear in the data set, *given* a particular underlying trait innovation rate, is important especially since it may represent one of the few ways of estimating innovation rates with only observable data.  

[^3]: I measure evenness in two ways:  [Shannon entropy](http://en.wikipedia.org/wiki/Diversity_index) and the "Index of Qualitative Variation," [@wilcox1973indices].  





### References Cited ###

  

 





