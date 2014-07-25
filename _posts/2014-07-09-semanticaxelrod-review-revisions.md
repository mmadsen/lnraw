---
layout: post
title: Semantic Axelrod Review Comments/Revision Plan
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Review Comments ###

Since the latest version went out for review in late May, I've gotten two sets of comments.  

#### Anon Reviewer ####

Note:  comments refer to double-spaced referee version.


1.  Reviewer noted that we focused on cultural evolution in hominins rather than the larger group of hominids, and suggested that we discuss social learning among other apes.  __Plan: This is a book series specifically about the modern human/Neanderthal transition, so at most I might point to a review of social learning outside this particular clade.__

1. Page 11:  A relevant aspect of the learning strategy discussion is the cost-benefit tradeoff of the teachers discussed in Shennan and Steele 1999.  __Plan:  Need to look at Shennan and Steele, might be good to mention, but we're not modeling the fitness of any particular strategy here.__

1. Page 21-24: A general question about the use of information with tree-structure concerns the suitability of this model for various cultural traits. When would non-tree structure be a better model for the structure of information? The justification of the tree structure as well as the various graph metrics needs to be more explicitly outlined in this section. This would help the reader understand the importance of different metrics of the graphs that are varied in the model. At the moment, it is difficult for the reader to trace the expectations of different graph structures or properties of the graph like automorphism.  __Plan: (a) new paragraph or subsection describing more explicitly how different network topologies would be useful in constructing different models of concept/trait relations, (b) stress how any design space model is a conceptual tool, and there can be many design spaces overlaid on the same set of cultural phenomena, depending upon the questions we ask.__

1. Page 26-27:  The link between the simulation experiments and the archaeological problem outlined in the introduction could be better articulated here.  __Plan:  I'm wondering if I'm not setting up expectations clearly enough, or perhaps I'm just not reiterating them well in Section 4.__

1. Page 29: What else could explain the extremely low cultural diversity that characterizes the material culture during the Lower and Middle Paleolithic? It is important to think about the overlap in outcomes between the variables presented in this model and other evolutionary forces including selection, particularly when discussing an analogy with technology that could have some outcome on food gathering, and processing.  __Plan: TBD__.  

#### Ken Aoki ####

Note:  comments refer to single-spaced Arxiv.org version.


1.  **DONE**:  Eq. (2) on page 12 appears to be a distance measure.  Shouldn’t the probability of interaction be  $1 - J(A,B)$?  __Plan:  KA caught an error, but the probability shouldn't be $1 - J(A,B)$, but just $J(A,B)$ given that we want similiarity, not dissimilarity.  But the equation as printed is incorrect, it should be $J(A,B) = \frac{|A \cap B|}{|A \cup B|}$.__    

1.  Fig. 5 reports important results, but is confusing because there are horizontal and vertical axes for each embedded figure as well as for the whole figure.  Perhaps one of the embedded figures could be presented separately and explained in detail.  __Plan:  Ken's right, this histogram matrix is doing too much work.  (a) Find a different way of capturing how the spread and centroid of distributions changes with design space size and prerequisite learning rate.  Much of the work here can be done by showing how regression slopes change, or?  (b) If I stay with histograms, perhaps show one first and thoroughly explain what it means.__

1.  Two lines below Fig. 5, it is stated “left hand peak corresponds to simulation runs which had no global innovation….”  Does this mean that the left hand peak represents runs in which innovation did not occur by chance?  __PLAN:  Need to focus only on the analysis with non-zero innovation rates.  Do not combine the two sets of simulation runs, to make this clearer.__

1.  In the paragraph below Fig. 7, you make the interesting statement “mean radius declines … due to the slower velocity at which an innovation diffuses.”  Are there any studies on the original Axelrod model that explore the effect of changing the interaction distance?  __PLAN:  I must be saying something which could lead to the impression that I'm talking about spatial effects here, and I'm not, so clarify.  There might be interesting spatial effects, but we're not doing anything spatial in this paper.__

1.  Design space is assumed to be finite, which entails that hominid imagination is also limited.  Could you discuss further what would be the effect of evolutionary advances in imagination?   __PLAN:  This is an important comment, and it's related to the conceptual/empirical thing I mention in the anonymous comments above.  Some of the design spaces considered here are practically infinite, from the perspective of a small population of individuals, and even in the smallest design spaces, the population explores a tiny fraction of the possible space.  But I should discuss this more explicitly.__

 






### References Cited ###

