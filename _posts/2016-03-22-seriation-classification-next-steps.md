---
layout: post
title: Next Steps for Classifying Seriations to Temporal Network Models 
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation, algorithms, ML]
categories:
- project-coarse grained model
- model-seriationct
- experiment-experiment-seriation-classification
---

### Where Things Stand ###

Initial experiments are promising, when using the sorted Laplacian spectrum as the features for building a classifier model.  Even with small samples, it seems to show the following:  

* We can tell lineage splitting from a complete network from a probabilistic nearest neighbor model
* We can't tell PNN models from each other given different shapes (aspect ratio) to the region

This comes from building a multi-class GB tree model from `sc-1`, `sc-3`, `sc-4-nn`, and `sc-4-nn`, and predicting the data generating model from a 10% holdout set.  

The classifier results hold pretty steady in a qualitative sets regardless of the random train/test split.  

What doesn't hold steady is the prediction and class probabilities for the PFG continuity graph.  I get different answers depending upon the train/test split, which is probably a function of:

*  Insufficient diversity in the network models used in simulation -- I need many examples of each network model
*  Sample size overall

Given that there isn't much overlap in the overall classification itself, my guess is that if we could look at this in the 10 dimensional space of the eigenvalues used, we would see that:

*  The PFG seriation is actually not deeply embeeded in the convex hull of points for any of the classes, but is near the edge of several or even all
*  That the decision boundaries shift a lot with respect to the area where the PFG seriation is located

Given this, a different train/test split could shift a decision boundary very slightly, without having a major impact on the overall confusion matrix among models, and thus change the predicted assignment for the PFG sample.  

We might be able to visualize something like the above by using a dimensionality reduction technique and mapping the models against say the first 3 principal components, and then putting PFG on the map.  Worth a try.  

### Computational Next Steps ###

But removing this issue and getting stable predictions for PFG is going to be a function of:

* More classes of network models, since PFG might not really be well described by any of the existing ones
* More network models per class
* More samples of simulations per network model (or model class)

While I develop more network models, I will probably start doing the second and third for the existing four models, but with PNN models collapsed down to a single model.  I don't have the formal infrastructure yet for doing multiple realizations of a single network model, so that's the first step.  

