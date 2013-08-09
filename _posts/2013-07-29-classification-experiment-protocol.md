---
layout: post
title: Classification Experiment Protocol
tags: [cultural transmission, classification, coarse graining, simulation, ctpy, dissertation, experiments]
category: coarse grained model project
---

### Purpose ###

The "packages" of information that people learn by observing others (e.g., craftspeople, parents) or being formally taught are variable in their "size."  This is true along several dimensions.  Two people may observe the same demonstration and retain different information.  Alternatively, a teacher may work with one student to pass on information about a whole tool or process, and with another student about an aspect of the tool or process.  And so on.  There is no "natural" unit or "package size" to cultural transmission, because culture is passed by a variety of physical and behavioral mechanisms.  

We detect and measure social learning by constructing analytic classifications pertinent to the problem domain, and then examining the abundances and spatiotemporal patterns of those classes.  Inevitably, our classifications are thus a "coarse grained" view of the actual social learning processes.  

We should not, therefore, expect that CT models derived from classical population genetics theory, or epidemiological theory, should give correct _quantitative_ predictions when we use them in a cultural context.  For example, unbiased transmission within a fixed population, with "always new" innovation, results in a distribution of trait frequencies which has a characteristic form.  

The purpose of this simulation model is to establish the formal relationship between CT models and analytic classifications, for the observable variables we seek to apply to empirical data. Specifically, I seek to understand:

1. Scaling -- how does each model observable change when we change the density of modes in a classification, or whether dimensions are broken into modes evenly or randomly?
2. Equifinality -- are there models (or parameter regions) that we can distinguish in raw trait space, but not when we observe the models through classifications (of given coarseness)?


### Experiment Outline ###

#### Preparation Steps ####

The only preparation needed is to initialize an experiment, by selecting a unique experiment name and registering it in the `experiment_tracking` database by running `initialize_experiment.py`.  The experiment name should be given on the command line as `--experiment EXPERIMENT` to all scripts.  


The script `construct_classifications.py` builds the classifications that will be used in the analysis steps.  The script constructs two tables in collection `EXPERIMENT_configuration`.  

The desired range of simulation parameters should be adjusted in `ctpy.__init__.py`.  **NOTE** It might have been a mistake to put these parameters into a python module, rather than configuration files, which could be named on a per experiment basis.  


#### Simulation Steps ####

Each model runs within simuPOP, using CTPy modules.  simuPOP will perform replications of a model run at a given set of starting parameters, but different initialized populations.  So each execution of a simulation model will given $R$ replications of a specific set of parameters.  

Each simulation execution runs a specific CT copying/innovation model, with a unique combination of the model's parameters (e.g., population size, innovation rate, conformism rates).  Each replicate constitutes an independent evolving population under those specific parameters, and each replicate is sampled independently and stored independently in the database as a "sample path." 

For the basic unbiased model with unbounded "always new" innovation (WF-IA), the core parameters are:

1. Population size
2. Innovation rate

Other models such as conformism would add the conformism rate or bias levels to the list of simulation parameters.  

Each simulation run stores raw samples of genotypes, and statistical measures, in a data collection called `EXPERIMENT_sim_rawdata`.    

#### Data Reduction Steps ####

In order to minimize the number of simulation runs, some data configurations can be derived by subsampling the results of an existing simulation run.  For example, if we are taking samples of multiple sizes from a population during a simulation run, we can simply record the largest sample size, and subsample the database for smaller sample sizes.  This is advantageous because simuPOP need not be loaded and running a live simulation to process the data stream and derive smaller samples.  

The following parameters will be handled by setting them to maximum values across all simulation runs, and generating subsample sample paths in the database in post-processing:

1. Sample size of individuals for statistics calculation
2. Number of trait dimensions each individual possesses

**NOTE** we can factor out trait dimensions in this way ONLY if we're using specific algorithms for copying and mutation.  In the unbiased case (WFIA), the simuPOP `RandomSelection` mating scheme copies a whole individual's genotype into the output population for the generation step.  And the `KAlleleMutator` applies the mutation rate to each locus independently (and can have specific mutation rates for each locus, if desired). These facts about the model code make it easy to factor out trait dimensions by subsampling.  IF, on the other hand, a CT model doesn't work this way, I may need to explicitly include `num_loci` in the simulation parameters Cartesian product. 

Subsampling occurs as follows:

1.  For a given `experiment_name`, we determine whether subsampling has previously occurred, by consulting the appropriate entry in `experiment_tracking`.  If subsampling has occurred, we exit.  
2. Otherwise, we select all raw data samples from `individual_samples` in `EXPERIMENT_sim_raw`.
3. For each data sample, we loop over the cartesian product of `DIMENSIONS_STUDIED` and `SAMPLE_SIZES_STUDIED` and for each combination, we construct a subsample of individuals with the specified number of loci.  
4. The subsample is then inserted into `EXPERIMENT_sim_raw`, in the `individual_samples_fulldataset`.  This segregates the original simulation output from post-processed output, allowing re-analysis if bugs are discovered in the processing chain, or we want to post-process with different parameter values. 
5. When complete, `experiment_tracking` is updated to reflect completion of subsampling. 


#### Analysis Steps ####

**PREPARATION STAGE**

1.  First check `experiment_tracking` to determine whether a given full dataset has been identified as to classes.  If so, exit.  
2. For each classification in `EXPERIMENT_configuration`:
3. Select all samples from `individual_samples_fulldataset` that have the same dimensionality as the classification.  
4. Identify each individual genotype as to class membership, save in a list.
5. Substitute the list of classes for the original genotypes into a copy of the individual sample record.
6. Insert the finished sample to the collection `EXPERIMENT_samples_postclassification`.  This keeps the processed samples in addition to the original data.  
7. Record completion in `experiment_tracking`.  


### References Cited ###


