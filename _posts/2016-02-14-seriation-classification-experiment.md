---
layout: post
title: Identifying Metapopulation Models from Simulated CT and Seriations 
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation, algorithms, ML]
categories:
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriation-classification
---

### Background ###

In a [previous note](http://notebook.madsenlab.org/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2016/01/26/quantifying-similarity-seriations.html), I described the problem of inferring the goodness of fit between a regional network model and the sampled output of cultural transmission on that regional network, as measured through seriations.  I am now ready with the simulation and inference code to start testing the spectral similarity metric I discussed in that note across pairs and sets of regional network models.  

Here, I describe the first such comparison.

### Experiment:  SC-1 ###

SC-1 is a simple contrast between two regional network models.  A regional network model is a time-transgressive description of the interaction patterns that existed among a set of subpopulations, described by an "interval temporal network" representation (see [note 2](http://notebook.madsenlab.org/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2014/11/28/more-temporal-networks-python.html) and [note 1](http://notebook.madsenlab.org/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2014/07/28/implementing-temporal-networks-in-python.html) about the implementation of such models).  

Both models are composed of 10 time slices.

Model #1 is called "linear" in the experiment directory because it should ideally yield simple, linear seriation solutions because the only thing occurring is sampling through time.  At any given time, the metapopulation is composed of 64 subpopulations each.  Each subpopulation is fully connected, so that any subpopulation can exchange migrants with any other, and there are no differences in edge weights (and thus migration rates).  Each subpopulation in slice $N$ is the child of a random subpopulation in slice $N-1$.  

Model #2 is called "lineage" in the experiment directory because it features 4 clusters of subpopulations, with 8 subpopulations per cluster.  Subpopulations are fully connected within a cluster, with edge weight 10.  Subpopulations are connected between subpopulations at fraction 0.1, with edge weight 1.  This yields a strong tendency to exchange migrants within clusters, and at a much lower rate between clusters.  For the first 4 time slices, all four clusters of subpopulations are interconnected, but in slice 4, a "split" occurs, removing interconnections between two sets of clusters, leaving ${1,2}$ interconnected and ${3,4}$ interconnected, but no connections between these sets.  The resulting clusters then evolve for 6 more time slices on separate trajectories, giving rise to a "lineage split."

Neutral cultural transmission is simulated across these two network models, with 50 simulation replicates on each model, and a common set of parameters:

```json
{
    "theta_low": 0.00001,
    "theta_high": 0.0001,
    "maxinittraits": 5,
    "numloci": 3,
    "popsize": 250,
    "simlength": 8000,
    "samplefraction" : 0.5,
    "migrationfraction_low" : 0.05,
    "migrationfraction_high" : 0.1,
    "replicates" : 1
}
```
Innovation rates and migration fractions are chosen uniformly at random from the ranges given for each simulation run.  Each locus evolves randomly, but we track combinations of loci as "classes" in the archaeological sense of the term as our observable variables.  Populations evolve for 8000 generations, giving approximately 800 transmission events per individual during a time slice (i.e., step in the regional metapopulation evolution).  We can think of that as approximately monthly opportunities for copying artifacts or behavioral traits, over a lifetime of approximately 65 years.

The raw data from each community in a simulated network model are then aggregated over the duration that community persists, giving us a time averaged picture of the frequency of cultural traits.  

I then perform the following sampling steps:

1.  I take a sample of each time averaged data collection similar to the size of a typical archaeological surface collection:  500 samples are taken without replacement from each community, with probability proportional to class frequency.  This yields a smaller set of classes, since many hundreds or thousands of combinations are only seen once or twice in the simulation data, and thus are very hard to measure from empirical samples.

2.  I then take a sample of communities to seriate.  From each of the two network models, I take temporally stratified samples, with 3 communities per time slice sampled out of the 64 present in each slice.  In real sampling situations, we would not know how communities break down temporally, but we often do attempt to get samples of assemblages which cover our entire study duration.  In the case of Model #1, we take a 5% sample of communities in each time slice.  In the case of Model #2, given the different structure of the model, we take a 12% sample of communities in each time slice.  

3.  Within the overall sample from each simulation run, comprised now of the time averaged class frequencies from 30 sampled communities, I examine the classes/types themselves, and drop any types (columns) which do not have data values for at least 3 communities.  This is standard pre-processing for seriation analyses (or was in the Fordian manual days of seriation analysis) since without more than 3 values, a column does not contribute to ordering the communities.  

The [IDSS Seriation](https://github.com/clipo/idss-seriation) package is then used to seriate the stratified, filtered data files for each simulation run across the two models.  

### First Classification Attempt ###

For a first classification attempt, I did a "leave one out" cross validation run, in which each seriation graph was sequentially deleted from the training set of 99 seriations (one lineage graph had issues with duplicate frequencies and became stuck in frequency seriation), and the distance from the hold-out target graph to all others calculated using [Laplacian spectral distance](http://notebook.madsenlab.org/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2016/01/26/quantifying-similarity-seriations.html).  The label of the target graph was then predicted as the majority vote of the 5 nearest neighboring graphs.  No attempt was made to tune the number of nearest neighbors using a second cross validation pass, but that will be the next experiment.

In general, the ability to predict the label (network model) which gave rise to the target seriation graph is decent:  76.8%.  

```
Classification Report:

          predicted 0  predicted 1
actual 0           41            9
actual 1           14           35
             precision    recall  f1-score   support

          0       0.75      0.82      0.78        50
          1       0.80      0.71      0.75        49

avg / total       0.77      0.77      0.77        99

Accuracy on test: 0.768
```

The details of classifier accuracy seem to show that we have better ability to correctly classify seriations which result from Model #1 ("linear") model than seriations originating from the lineage splitting Model #2.  In particular, we correctly identify instances of Model #1 82% of the time (recall), although there are clear issues with false positives.  The ability to identify instances of Model #2 is worse, with a considerable number of false negatives.  

In the next experiment, I intend to see if different values of the k-Nearest Neighbor parameter affect this accuracy, but I expect that achieving higher accuracy might require augmenting the approach.  One possibility that bears exploration is to not simply use the spectral distance, but to instead use the Laplacian eigenvalues themselves (sorted in decreasing order) directly as features, in addition to other graph theoretic properties such as average degree and tree radius, and use a more traditional classifier like boosted decision trees.  That will probably be my third experiment.  

### Second Attempt ###

In a second run, I examined the effect of the number of nearest neighbors which "vote" on the label of the target seriation, still with leave-one-out cross validation.  The results seem to indicate that (at least for these models) that best performance is 3 nearest neighbors, with accuracy worsening for 5, 7, and 9 neighbors, and then plateauing a bit for 11 and 15 neighbors.  But with 3 neighbors, we achieve almost 80% accuracy, which is encouraging.  

```python


knn = [1, 3, 5, 7, 9, 11, 15]
for nn in knn:
    gclf = skm.GraphEigenvalueNearestNeighbors(n_neighbors=nn)
    test_pred = []
    for ix in range(0, len(train_graphs)):
        train_loo_graphs, train_loo_labels, test_graph, test_label = leave_one_out_cv(ix, train_graphs, train_labels)
        gclf.fit(train_loo_graphs, train_loo_labels)
        test_pred.append(gclf.predict([test_graph])[0])
    print("Accuracy on test for %s neighbors: %0.3f" % (nn, accuracy_score(train_labels, test_pred)))
```

Results:

```    
Accuracy on test for 1 neighbors: 0.788
Accuracy on test for 3 neighbors: 0.798
Accuracy on test for 5 neighbors: 0.768
Accuracy on test for 7 neighbors: 0.747
Accuracy on test for 9 neighbors: 0.758
Accuracy on test for 11 neighbors: 0.788
Accuracy on test for 15 neighbors: 0.788
```


### References Cited ###

