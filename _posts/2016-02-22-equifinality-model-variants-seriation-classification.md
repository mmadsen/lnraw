---
layout: post
title: Limits of model resolution for seriation classification 
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation, algorithms, ML]
categories:
- project-coarse grained model
- model-seriationct
- experiment-experiment-seriation-classification
---

### Model Resolution and Equifinality ###

Experiment `sc-2` was designed to examine the opposite question as `sc-1`; that is, when do we lose the ability to distinguish between regional interaction models by examining the structure of seriations from cultural traits transmitted through those interaction networks?  This is a question of equifinality of models:  do different models have empirical consequences which are indistinguishable given a particular observation technique?  

To test this, I set up four models which I believe to be very "close" to each other:

1.  Lineage splitting where 1 lineage turns into 2 lineages, the split occurring 30% of the way through the time sequence ("early split")
2.  Lineage splitting where 1 $\rightarrow$ 2 lineages, split occurring 70% of the way through the time sequence ("late split")
3.  Lineage coalescence where 2 lineages turn into a single linage, the event occurring 30% of the way through the sequence ("early coalescence")
4.  Lineage coalescence where 2 $\rightarrow$ 1 lineages, split occuring 70% of the way through the time sequence ("late coalescence")

In all other respects, simulation of cultural transmission across these regional networks was identical, using the same prior distributions for innovation and migration rates, population sizes, and so on. 

My expectation going in was that the lineage splitting and coalescence models should generate seriations which are almost indistinguishable from one another, except for their temporal orientation, and with the paired early/late comparisons, it may be difficult to tell any of these models from one another without additional feature information.  In particular, I expected roughly chance performance on classification unless we could provide temporal orientation, and even then, we may only be able to tell coalescence from splitting models.   


### Initial SC-2 Analysis ###

The analysis of `sc-2` followed the method used in the [second trial of `sc-1`](http://notebook.madsenlab.org/project-coarse%20grained%20model/model-seriationct/experiment-experiment-seriation-classification/2016/02/16/feature-engineering-seriation-classification.html), calculating the Laplacian eigenvalue spectrum of the final seriation solution graphs (specifically, the `minmax-by-weight` solutions for continuity seriation), and using the sorted eigenvalues as features for a gradient boosted classifier.  

The initial results seem indicative of real trouble telling these models apart.  For guidance, class labels are as follows:

0.  Early splitting
1.  Early coalescence
2.  Late split
3.  Late coalescence

Given a hold-out test set, we see the following performance:

```

          predicted 0  predicted 1  predicted 2  predicted 3
actual 0            3            2            0            0
actual 1            1            1            0            0
actual 2            0            0            2            2
actual 3            0            0            4            5
             precision    recall  f1-score   support

          0       0.75      0.60      0.67         5
          1       0.33      0.50      0.40         2
          2       0.33      0.50      0.40         4
          3       0.71      0.56      0.63         9

avg / total       0.61      0.55      0.57        20

Accuracy on test: 0.550
```

The overall accuracy is low, but the pattern of misclassifications is key here.  We never see "early" models misclassified as "late" models, but we do see splitting misclassified as coalescence (possibly because we have no orienting information).  So while overall accuracy is low, we actually have perfect discrimination along one dimension of the models:  when events that alter lineage structure occur, in relative terms.  Not bad, considering how "close" in structure these regional interaction models are.  

### Optimizing Classification Performance ###

The above was conducted with "reasonable" hyperparameters for the gradient boosted classifier, but I want to understand our best performance in separating these models.  This is accomplished by setting the hyperparameters through cross-validation.  In this case, I used a grid search of the following variables and parameters for the learning rate penalty, and the number of boosting rounds (number of estimators):

```python
     'clf__learning_rate': [5.0,2.0,1.0, 0.75, 0.5, 0.25, 0.1, 0.05, 0.01, 0.005],
     'clf__n_estimators': [10,25,50,100,250,500,1000]
```

Using 5-fold cross validation, this produced 350 different fits of the classifer, with the following results:

```
Best score: 0.593
Best parameters:
param: clf__learning_rate: 1.0
param: clf__n_estimators: 50
```

Some improvement is seen on overall training set accuracy, but the real surprise is test performance on the hold-out data, using the optimal hyperparameters:

```
          predicted 0  predicted 1  predicted 2  predicted 3
actual 0            3            2            0            0
actual 1            1            1            0            0
actual 2            0            0            3            1
actual 3            0            0            3            6
             precision    recall  f1-score   support

          0       0.75      0.60      0.67         5
          1       0.33      0.50      0.40         2
          2       0.50      0.75      0.60         4
          3       0.86      0.67      0.75         9

avg / total       0.71      0.65      0.66        20

Accuracy on test: 0.650
```

Overall accuracy is greatly improved, which is unusual (normally I would expect test accuracy to be less than training accuracy, but the test set is small).  But we can see that we improved mainly because of our ability to predict classes 2 and 3, although the overall pattern is still the same:  we have misclassification within early and within late, but perfect discrimination between the two.

### Summary ###

Given how close these models were, I expected to have great trouble in identifying them from seriations.  What I found is that I can identify part of the model class with great accuracy, and that the other modeling dimension (coalescence/splitting) with much less accuracy.  This leads me to suspect that I could predict both dimensions with very high accuracy if I were to find a way to encode temporal orientation as a feature. 

I will pursue this, since we often have at least **some** information on temporal orientation, perhaps by knowing that one assemblage in a set is much earlier or later than the rest.  The challenge is finding a way to provide this kind of hint for the synthetic seriation graphs.  More soon on this.



### Resources ###

[Full analysis notebook](http://nbviewer.jupyter.org/gist/anonymous/f6a18712ee1077d1a329) on NBViewer, from the Github repository.

Github Repository:  [experiment-seriation-classification](https://github.com/mmadsen/experiment-seriation-classification) 





### References Cited ###

