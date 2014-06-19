---
layout: post
title: Slatkin Exact Test -- Error and Statistical Power
tags: [cultural transmission, experiments, dissertation,neutral model, statistics]
categories: 
- project:coarse grained model
- experiment:slatkin-power
---


## Power Analysis ##

$H_o$: WF-IA

$H_a$: Conformist model from Mesoudi and Lycett (i.e., prob $c$ of taking most common trait)


Questions:

1.  At what point does power decline below 50% as we adjust the conformism parameter $c$?  This would be a good measure of equifinality between the two models.
1.  How does power vary with time averaging duration?  We might expect that TA in the case of conformism would give time for additional traits to accumulate and thus mimic the neutral distribution of traits under ESD.  Under this circumstance, we'd expect power to decline.  But if the frequencies of the very most common traits are simply reinforced by conformism, power would increase.  
1.  Finally, it would be good to recognize that the currently implemented conformism model is "extreme" in a sense, since it focuses conformity on only one trait at a time.  This type of model should be the most easily distinguished from neutrality since even small conformist probabilities concentrate a lot of mass on the single most common trait at any given time, and that trait also has strong persistence in the population.  
1.  An intermediate, and possibly more realistic model of conformism in transmission is to overweight all traits whose frequency is greater than the mean, underweighting those lower than the mean, by some factor which is additive on top of their probability of being copied given frequency alone.  I.e., a biased multinomial model.  This would lead to concentrations of popular traits, certainly, but less concentration on single traits, and thus Slatkin tests would presumably have less power against such a model, compared to the Mesoudi-Lycett-style conformism model.  


## Notes ##

Usual practice in archy usage today is to treat class frequencies from an assemblage as a sample of "individuals" which can be tested with the Slatkin/Ewens test.  

A quick look at Carl's recollection of Belle Meade showed that individual collection units have a fairly wide variation in $P_e$ values, but all of the ones I checked fit within an $\alpha = 0.05$ test.  

**Precision and Variance of Slatkin Tests**

1. Within a single assemblage with multiple collections, what is the range of $P_e$ values?  If we look at the empirical distribution of $P_e$ for Belle Meade collections, how well does it fit a Gaussian, and what is the CI?
1. How does the mean value of the empirical distribution compare to the $P_e$ calculated on the aggregate assemblage?

**Bootstrap Analysis of Assemblage**

Treat aggregate assemblage as a sample and investigate behavior of bootstrap sampling for $P_e$.  

Repeat bootstrap sampling on simulated data.  

1.  Range of $n$ sample sizes - how do $P_e$ vary with $n$ in a real assemblage?
2.  How do results compare between empirical distribution and simulated data?


**Mixture Distributions**

Since real populations are never "pure strategists" in terms of copying rules, none of our CT models actually can be a "true model."  Leaving aside other model features such as population structure for the moment, at a minimum, the true "data generating process" (DGP) 



