---
layout: post
title: CTMixtures Cost Analysis
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Cost Estimate ###

The following estimates are based upon the AWS instance profile given below, and from measurements of execution times on the actual configured StarCluster compute cluster.  The simulation code runs 1.7 times **slower** on the c3.xlarge EC2 instance as on my Macbook Pro.  Sadly.  

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



### AWS Instance Profile ###

|------------------------------|----------------------------------------|------------------------------------|
| Instance Type Used           | c3.xlarge                              | c3.xlarge                          |
| vCPUs per instance           | 4                                      | 4                                  |
| Cost per instance/hour       | $0.21                                  | $0.21                              |
|------------------------------|----------------------------------------|------------------------------------|