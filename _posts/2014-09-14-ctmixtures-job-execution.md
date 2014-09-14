---
layout: post
title: CTMixtures Experiment Configuration and Execution
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Background ###

Given a `StarCluster` running the `ctmixtures-cluster` AMI on EC2, it is possible to configure, run, and monitor a very large number of simulation models.  These notes record how I'm doing it.  

There are two main approaches to running the simulation jobs:

1.  Granular - submit each simulation as a separate job
2.  Coarse - for N instances x M vCPU, submit $N * M$ jobs 

In theory, there should be no difference in the final result, but if we want to plan for eventualities like crashes, or the need to restart jobs which throw errors (unlikely, but it's possible), a granular approach might be best.  But for very large numbers of jobs, it's unclear to me how SGE handles job queues in the $10^5$ or $10^6$ range.  So for my first experiment, which employs 100K simulation runs, I'm going to try something in the middle.  

3.  Semi-granular -- each "job" is a batch of 100 simulation runs

SGE and StarCluster are responsible for pipelining each batch of 100 across the available vCPUs in the cluster, and if a job encounters a problem, that batch can be investigated and restarted without strongly delaying the overall completion time.  Thus, a set of 100K simulation runs would yield 1000 job scripts, each containing 100 command lines to execute an individual simulation.  

### Experiment Construction ###

This is constructed in `ctmixtures` using the `ctmixtures-priorsampler-runbuilder.py` program, as follows:

```{.shell}
$ ctmixtures-priorsampler-runbuilder.py --experiment clustertest --simprefix /usr/local/anaconda/bin --expconfig neutral-priors.json --confprefix /home/sgeadmin --configuration /sim/src/an-al-wm.json --debug 0 --parallelism 1000 --numsims 100000 --model neutral
```

This program produces 100,000 shell commands, each of which executes one simulation run, with parameters either specified in the `expconfig` configuration for the experiment as a whole, or sampled from prior distributions given in the `expconfig`.  The example given is simulating a pure neutral model, for which there is one prior distribution, the scaled population level innovation rate (given in standard units of $2N\mu$ following standard practice in population genetic theory).  The contents of `neutral-priors.json` are as follows:

```{.json}
{
    "theta_low": 0.1,
    "theta_high": 5.0,
    "kandler_interval": 50,
    "maxinittraits": 10,
    "numloci": 4,
    "popsize": 100,
    "endtime": 1000000
}%

```

Variables with suffixes "low" and "high" represent uniform priors over the given range.  Other single-valued variables are point parameters, or general simulation configuration (e.g., endtime).  

For any prior distributions, the runbuilder will sample the given number of simulations (e.g., 100,000) over joint draws from all of the priors, and give each simulation run a unique random seed in the range $[1, 2^{62}]$.  

The simulation configuration itself specifies several other parameters common aross the set of simulations, and the names of Python code classes which are used to construct the desired simulation model (the code is a modular framework).  An example of a pure neutral model is:

```{.json}
{
    "TIME_AVERAGING_DURATIONS" : [50,100,200],
    "SAMPLE_SIZES_STUDIED" : [25,50,100],
    "INTERACTION_RULE_CLASS" : {"ctmixtures.rules.NeutralAllLociCopyingRule": 1.0},
    "POPULATION_STRUCTURE_CLASS" : "ctmixtures.population.FixedTraitStructurePopulation",
    "INNOVATION_RULE_CLASS" : "ctmixtures.rules.InfiniteAllelesMutationRule",
    "NETWORK_FACTORY_CLASS" : "ctmixtures.population.CompleteGraphFactory",
    "TRAIT_FACTORY_CLASS" : "ctmixtures.traits.LocusAlleleTraitFactory",
    "TIME_AVERAGING_CLASS" : "pytransmission.aggregation.MoranCumulativeTimeAverager",
    "DYNAMICS_CLASS" : "ctmixtures.dynamics.MoranDynamics",
    "MODEL_CLASS_LABEL" : "pureneutral"
}
```

The "INTERACTION_RULE_CLASS" is used to create mixture models, where a specified proportion of the population is represented by a Python class giving a social learning rule.  The other class specifications here yield a population with locus/allele trait structure, infinite-alleles innovation (i.e., no back-mutation to existing alleles), well-mixed interaction (i.e., agents sit on a complete graph), and the simulation runs according to the Moran approximation to a continuous time Markov process.  

This model is given a label, `pureneutral`, which is usable by logistic regression, support vector machines, or ABC methods to perform a classification of the resulting data and cross validation, which is the cornerstone of the `ctmixtures` equifinality analysis.  

Executing the runbuilder as above yields 1000 shell scripts in the current working directory, named as `simrunner-exp-clustertest-neutral-392.sh`.  

The two "prefix" options cause the runbuilder to prepend absolute paths for the simulation script itself and its configuration file, to allow for clean execution on the cluster nodes regardless of whether SGE and StarCluster copy and execute job scripts.  In this case, `/usr/local/anaconda/bin/sim-ctmixture-timeaveraging.py` already exists given the `ctmixtures` setup and install script (`setup.py` in the GitHub repository).  The configuration file will be covered in the next section.

### Experiment Execution ###

After executing the runbuilder, I bundled the job scripts and simulation configuration file (e.g., an-al-wm.json, which specifies an all-neutral model, where copying occurs across all loci simultaneously -- whole repertoire copying, in a well-mixed population).  Before archiving into a tar file, I made the job scripts executable.    

```{.shell}
$ chmod +x *.sh
$ tar cvf clustertest-job.tar *.sh *.json
```

This tar archive (zip is fine too) is then copied to the master node of your running compute cluster.  **The StarCluster "put" command gave me an error about not being able to find the master node, in version 0.95, so I fell back to direct SSH/SCP copying, specifying the appropriate EC2 IAM RSA key on the command line**

On the master node, I unpacked this tar archive in the large EBS volume, under `/sim/src`, and copied the simulation configuration file to `/home/sgeadmin/conf`.  Everything under `/home` is shared among the cluster nodes via NFS, so it will automatically be visible in this location to all of the compute nodes.  

At this point, I am ready to submit jobs.  First, I became the `sgeadmin` user, for access to running Sun Grid Engine commands.  Then, each job script is given to the `qsub` command, which submits a job to the queue.  In the following, I assume that the job scripts are directly in `/sim/src` where they were unpacked.

```{.shell}
(root)$ su - sgeadmin
(sgeadmin):/home/sgeadmin$  for d in `ls /sim/src/simrunner*.sh`; do ( qsub -V $d ); done
```

Once submitted, the `qstat` command gives you a list of the state of all jobs in the queue.  Initially each job will be in the `qw` state as it initializes, and switch to `r` as it runs.  In the current directory where the job commands were run, each job will have two output files, with suffixes `.e<job id>` and `.o<job id>`, respectively.  The former captures STDERR, and the latter STDOUT.  Thus, a typical error file would be:  `simrunner-exp-foo-neutral-0.sh.e105` for job 105.  

By default, the jobs are submitted first to fill all SGE slots (i.e., vCPUs) on one compute node, before moving to the next compute node.  For a very long running batch like this, it doesn't matter how we submit them, but to switch to round-robin mode (circulating among compute nodes, one job to each until all vCPUs are full):

```{.shell}
(sgeadmin):/home/sgeadmin$  qconf -mp orte
```

This will open a VI editing session, and you can change the variable `allocation_rule` to `$round_robin`.

### Finishing a Simulation Batch ###

At the completion of a simulation batch:

1.  Export simulation data from MongoDB
1.  Copy simulation data from each node back to a local machine
1.  Stop and terminate the cluster 

**More detail on data export is forthcoming, after I do some tests on batch export and copying, which will help a great deal with large clusters**

