---
layout: post
title: CTMixtures Cost Analysis
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Initial Cost Estimate ###

The following estimates are based upon the AWS instance profile given below, and from measurements of execution times on the actual configured StarCluster compute cluster.  The simulation code runs 1.7 times **slower** on the c3.xlarge EC2 instance as on my Macbook Pro. 

The comparison here is for 1MM time steps, Kandler-Shennan trait survival interval of 50 generations, and a population size of 100 individuals, but comparing batches of 200K and 100K simulation runs.  This is an attempt to see what various sample sizes will cost.



|------------------------------|----------------------------------------|------------------------------------|
| Number of total runs         | 200000                              | 100000                         |
| Minutes to run single sim    | 4.3                                   | 4.3                               |
| Instances Used               | 10                                  | 10                              |
| vCPUs Used                   | 40                                  | 40                              |
| Runs per hour per vCPU       | 13.95                                  | 13.95                              |
| Runs per hour per instance   | 55.81                                  | 55.81                              |
| Hours to completion          | 358.33                                 | 179.17                             |
| Days to Complete Runs        | 14.93                                  | 7.47                               |
| Instance/hours to completion | 3583.33                                | 1791.67                            |
| **Cost to Completion**           | **$752.50**                                | **$376.25**                            |
|------------------------------|----------------------------------------|------------------------------------|


### First Batch Cost Estimate ###

100K and 200K were initially selected in order to (1) capture the variability that can occur in sample trajectories, (2) especially with multiple parameters in the conformist mixture case.  But it is an estimate, and I can also proceed incrementally.  Thus, 

For each of the 4 models in the `equifinality` experiment, I'm going to start with 10,000 samples, and do a first batch of 40,000 simulation runs, and analyze that as a training data sample.  Adding further samples from particularly variable models may or may not be necessary as a second step.  Finally, I will generate a test data set from the same priors to use the final classifier on to determine out-of-sample classification success, as my final measure of equifinality.  

The estimate for 40,000 runs is about 150.00, with 8 instances and only about 716 instance-hours.  


### AWS Instance Profile ###

|------------------------------|----------------------------------------|------------------------------------|
| Instance Type Used           | c3.xlarge                              | c3.xlarge                          |
| vCPUs per instance           | 4                                      | 4                                  |
| Cost per instance/hour       | $0.21                                  | $0.21                              |
|------------------------------|----------------------------------------|------------------------------------|

The [spreadsheet containing the original analysis](https://github.com/mmadsen/experiment-ctmixtures/blob/master/explorations/timing-analysis.xlsx) is located on GitHub.  

