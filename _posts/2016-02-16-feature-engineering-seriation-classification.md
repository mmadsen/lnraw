---
layout: post
title: Feature Engineering for Seriation Classification 
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation, algorithms, ML]
categories:
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriation-classification
---

### Feature Engineering ###

In my [previous note](http://notebook.madsenlab.org/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriation-classification/2016/02/14/seriation-classification-experiment.html), I used the graph spectral distance (i.e., the euclidean distance between Laplacian eigenvalue spectra from two seriation solutions) in a kNN classifer to predict which regional network model generated a seriation graph.  This achieved accuracy around 80% with 3 nearest neighbors.  

Doing better meant changing approaches, and giving the classifier a larger space within which to draw decision boundaries.  My first thought was to not reduce the Laplacian spectrum to distances, but instead of use the spectra themselves as numeric features.  This would require that, say, column 1 represented the largest eigenvalue in each graph's spectrum, column 2 the second largest, etc, which is easily accomplished.  

The resulting feature matrix is then suitable for any classifier algorithm.  I chose gradient boosted trees because of their high accuracy (essentially equivalent to random forests or better in most applications), and without any hyperparameter tuning at all, achieve anywhere from 85% to 100% accuracy depending upon the train/test split (it's a small sample size).  Optimizing hyperparameters improves this and I can get 100% pretty often with different train test splits.  

So this might be the standard method for seriation classification for the moment.  The good thing is that it lends itself to direct interpretation as an ABC (approximate Bayesian computation) estimator, as described in [@pudlo2014abc], especially if I actually use random forests (although I'm not sure the random forest bit is terribly important). 


### Implementation Details ###

The following code snippet takes a list of NetworkX graph objects, and returns a Numpy matrix with a chosen number of eigenvalues (it isn't clear how many are relevant):

```python
def graphs_to_eigenvalue_matrix(graph_list, num_eigenvalues = None):
    """
    Given a list of NetworkX graphs, returns a numeric matrix where rows represent graphs, 
    and columns represent the reverse sorted eigenvalues of the Laplacian matrix for each graph,
    possibly trimmed to only use the num_eigenvalues largest values.  If num_eigenvalues is 
    unspecified, all eigenvalues are used.
    """
    # peek at the first graph and see how many eigenvalues there are
    tg = graph_list[0]
    n = len(nx.spectrum.laplacian_spectrum(tg, weight=None))
    
    # we either use all of the eigenvalues, or we use the smaller of
    # the requested number or the actual number (if it is smaller than requested)
    if num_eigenvalues is None:
        ev_used = n
    else:
        ev_used = min(n, num_eigenvalues)

    print "(debug) eigenvalues - test graph: %s num_eigenvalues: %s ev_used: %s" % (n, num_eigenvalues, ev_used)
    
    data_mat = np.zeros((len(graph_list),ev_used))
    #print "data matrix shape: ", data_mat.shape
    
    for ix in range(0, len(graph_list)):
        spectrum = sorted(nx.spectrum.laplacian_spectrum(graph_list[ix], weight=None), reverse=True)
        data_mat[ix,:] = spectrum[0:ev_used]
        
    return data_mat
```





### Resources ###

[Full analysis notebook](http://nbviewer.jupyter.org/github/mmadsen/experiment-seriation-classification/blob/master/analysis/sc-1/sc-1-seriation-feature-engineering.ipynb) on NBViewer, from the Github repository.

Github Repository:  [experiment-seriation-classification](https://github.com/mmadsen/experiment-seriation-classification) 





### References Cited ###

