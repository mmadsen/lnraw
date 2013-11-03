---
layout: post
title: Simply Statistics Unconference on the Future of Statistics
tags: [conference, statistics, data science, analytics, reading notes]
category: "reading notes"
---

[Simply Statistics - FOS Unconference](http://simplystatistics.org/unconference/)

### Hadley Wickham ###

* Future of statistical software
* What should statistical software do? 
* questions and data lead to tidying
* then cycle between munge, visualize, model
* every real analysis iterates through the cycle

Where are the bottlenecks?

* Cognitive 
* Computational

* Small data = cognition time $\gg$ computation time
* Big data = computation time $\gg$ cognitive time

Most software optimized for cognitive or computational challenges.  Can we have both?

Current projects:

* dplyr
* ggvis

Future Directions:

* PDF moving to HTML
* Latex to markdown
* static to interactive
* Openness:  open source, science, research
* R repositories on Github - over 6K, only about 2K packages

### Daniela Witten ###

UW Biostatistics

One huge area of growth is development of statistical machine learning for large data sets.  
Last 10 years, very good at making predictions based upon data.

Frontier is moving to inference from prediction.  We're good at saying, "based on what you buy, we
predict you'll buy X".  But asking, "how certain are we that you'll buy X?" is inference.  

Sometimes we don't care about inference, but often we do want confidence intervals, we might want to understand underlying relationships.  

Inference methods for machine learning is under developed.  Why is it hard?  Inference is pretty basic in statistics.  

For example, the lasso is very useful for regression for predictions in high dimensional problems with more variables than observations.  We only sort of understand the theory behind the lasso.  But the basic question about p-values and conf intervals for the variables selected by the lasso is unknown.  Just scratching the surface.  

### Joe Blitzstein ###

Undergrad probability:  too many classes where it's taught like a calculus class.  problems are out of context, and we need people to understand the core of probability and how to look at the world probabilistically.  Emphasize the stories behind the famous distributions - what problems stimulated their development?

More integration with computer science in the education process.  Teaching data science

Stat110.net - good examples of problems online.  CS109.org - co taught at Harvard with Hans-Peter, whole cycle Hadley talked about

Graduate:  do we need a full year of measure theory?  no.  but you need some measure theory.  we need more of the parts of math that are about "seeing structure," less about proving edge cases -- let mathematicians themselves do that.  More emphasis on matrices, and the major distributions, and how they're connected.  Hoping that the reconcilation between frequentists and bayesians continues.  We can be both -- compatibilists.  Good arguments for using both perspectives.  

### Hongkai Ji ###

Future of statistics in biology

Biological sciences played huge role in shaping the history of statistics.  Fisher - ANOVA and design of experiments came from agriculture and genetics (Wright).  

Similarly, high dimensional data in genomics is driving lots of method development today.  Real scientific problems stimulate statistical theory and method development.  But methods also feed back, and we can address new problems because of them.  

Trends - rapid devel of high throughput tech, often leads to a wave of new methods as the capacity increases.  20 years ago, microarrays, now, next-gen sequencing.  

Vast amounts of data publicly avail - GEO:  more than 1MM samples.  ENCODE, cancer genomic atlas, roadmap of epigenomics, etc.

Natural question - can we use these data?  Can we do things that people previously could not do?

Human genome - about 1400 TF's, each controls 100s to 10K's of other genes.  
Current tech - study single TF's at a time.  But we need to study all TF's at a time.  
Network is dynamic, changes from cell type to cell type
Thousands of cell types and across time points

But can we do this via analytics?  
cross data type predictions
both predictors and outcome variables are high dimensional

Histone modfication and TF binding
Expression and TF binding
Expression and DNA methylation

### Sinan Aral ###

MIT Sloan

Importance of causal inference

We now have timestamped granular observations of human behavior

Need to focus on experimental controls.  Prediction is incredibly valuable.  

But we need causal inference -- what will happen if we intervene?

Milgram etc ran experiments on hundreds of people.  We can do it on millions, hundreds of millions. 

the advantage of scale over smaller experiments - treatment of heterogeneity, not just main treatment effects.  We can estimate treatment effects across heterogenous classes with good power.  Enables us to develop personalized or tailored policies.  Average treatment effects allow blanket policies.  Heterogeneity allows us to target policy differently to different people.   

And scale allows us to understand causal mechanisms -- why does an intervention work?  

Scale allows us to pick up subtle but important effects - not just big obvious ones.  

Challenges - bias here on network data given his own work.  

Data are not IID.  All the data we thought were IID, aren't.  At least with human data sets.  No such thing as independence.  Methods for dealing with non-IID data, robustly, at scale, are incredibly important.  Some models deal well with interdependent data, but not at scale.

Sampling - recruitment strategies for large-scale experiments.  How do you avoid selection bias?  Respondent driven sampling creates biases.  

Interference - treated nodes connected to nontreated nodes via complex network structures.  Treatments interfere with one another - hard to "separate" treatment groups.  A couple of approaches - design strategies, inference strategies.  Exposure models - base inference on the exposure model, but you have to assume that the exposure model is correct, and testing it is hard.  

### Hilary Mason ###

Business and statistics

* data scientists can do statistics
* data scientists can write code - ranging from tidying real world data to building production systems
* data scientists interpret business problems and tell stories from data so that original business problem is answerable to biz consumers without the analysis and stats themselves.  

Harlan Harrison - what people do

* Business analytics - more realtime version of traditional BI
* Products - tons of things like predictions, recommender systems (doesn't think we're as good at predictions as some of the speakers claim)
* Research enabling new capabilities - using tech and data, what new opportunities can we open up?  
Need tools not just for stats or data scientists, but for business folks.  most data are still analyzed in Excel.  Like to see a similar set of tools but with robust data analysis to all jobs.  

Bit.ly - most analysis in python, rewrote in python, rewrite again in C or Go, wait until it breaks, fix, redeploy.  Need to develop ways to implement algorithms in ways that we don't have to keep reimplementing all the time.  

### Questions ###

How to teach reproducible research to undergraduates?  Hadley - Rpubs and Rmarkdown for homework make it easy.  Easier than doing homework by hand, actually.  







