---
layout: essay
title: Changing Strategy for Cultural Transmission Computing
tags: [cultural transmission, simulation, computing, HPC, seriation, computational science]
categories: 
- essays
---

### Background ###

For the last two or three years, my computing strategy for simulations (and post-simulation analysis) of cultural transmission models has been as follows:

1.  Develop simulation code in Python, sometimes with a framework which has C++ extensions for speed.  
2.  Test code on my laptop (quad-core, OS X), and occasionally make performance changes.
3.  Run production analyses and large parameter sweeps on clusters of Amazon EC2 instances, gathering results in a database.
4.  Do final analyses locally on my laptop unless they, too, needed a very large machine or a cluster.

This isn't a bad strategy:

1.  Python is usually fast enough.  
2.  Using EC2 means that I don't have to manage extra hardware, and I'm not worried about investing in hardware that goes obsolete quickly.
3.  Using EC2 also means that I can select the right **amount** of hardware for problem, and only pay for what I use.
4.  Using straight Python has meant that development velocity is fast, given the forgiving nature of a dynamically typed scripting language and the huge library support.

The negatives been cost and performance.  On average, I've been spending anywhere from $250 - $600 a month when I'm doing heavy analyses, and nothing sucks worse than having a cluster of 8 big compute-optimized instances grind away for a full week and then discover that you really needed to do the analysis a bit differently (and that you just burned a hundred bucks or more on CPU time that contributes nothing to the final result).  

The bigger problem has been the "cycle time" on simulation experiments.  When it takes a week or two weeks to go from a new simulation code to a set of results one can assess, it can take months to go from an idea to a full set of results.  This is just too long, especially as I try to deal with the last, and hardest, element of my dissertation research.  I'd like to reduce this cycle time so that I can test more ideas, so that false starts aren't so costly, and because the search space for the problem I'm addressing is huge, so I need to be able to do large samples.

I managed to do 27 different numerical experiments in about two months for a conference last winter, where most of the iteration time involved doing a large number of seriations from each round of simulation experiments.  While further scripting and automation will help with cycle time, I also need to simply improve computational throughput on seriation and analyses (and secondarily, on the primary CT simulations themselves, although this was less important in the cycle time).
  

### Improving Cost ###

Improving my costs should be easy, over time.  Routinely, I've been using EC2 instances with 8 or 16 cores so I can run multiple simulations, or give our seriation algorithms enough cores to test possible solutions in parallel.  Having such a system inhouse will be cheaper than using EC2 for the majority of my work if I keep it working for at least 18-24 months, given what I'm averaging on EC2 right now, and if I don't need to "burst" higher with EC2 very often.  On a couple of occasions, I've used clusters of instances with 64 total cores to handle a large batch of simulations that required long run times.  

So I set out with the goal to buy one mid-sized system with enough computing power to allow me to run most jobs locally, and save EC2 computing for occasional large tasks.  

### Many Core Architecture ###

It's easy to spec out an 8 core Xeon system, and put a large gamer/prosumer grade NVIDIA GPU into it, and call that a good development system.  Except that it's not clear that the GPU programming model will help me much, although there are certainly areas where being able to offload large matrix calculations to a GPU (using NumbaPro from the [Anaconda Python folks at Continuum.io](http://continuum.io), for example) might help with the fitting of statistical models.  GPU programming relies upon a very specific computing model, called "SPMD", an extension of the general SIMD model for vectorization.  In SPMD, a large calculation is broken down into an elemental function which operates on a single cell or small group of cells, performing exactly the same calculation (or "kernel") on each, which are then combined by the runtime into the result for an entire data block.  

This model is perfect for graphics computation, of course, given the origins of the GPU programming model. But it's terrible for general parallel programming, and worse than the host CPU for general combinations of serial and parallel code.  And unfortunately, most simulation programming in the social sciences doesn't fit neatly into the SPMD/GPU model.  Code which contains conditional branches will block the lockstep flow of computation across all of the compute cores in a GPU, and yield performance even slower than the host processor in many cases.  And even if I can rethink the way my simulation codes work, and eliminate if/then branching logic in favor of masked pipelines of small kernels run in sequence, the redevelopment time would be long and there's no guarantee of a major speedup.  

But we live in interesting times, and Intel's recent MIC architecture (embodied in the Xeon Phi coprocessor) offers a different path.  The current generation of the Phi (the first production generation, code named "Knight's Corner") started shipping to general customers in 2012 and 2013, and are now the cornerstone of the fastest supercomputer on record, [Tianhe-2](https://en.wikipedia.org/wiki/Tianhe-2), which has 16K compute nodes, each of which has two Xeon processors and 3 Phi cards.  

The Phi cards shipping today offer an embedded Linux subsystem, with 61 cores capable of over 1 teraflops/sec of double precision floating point performance (if you can feed it enough data smoothly enough).  This means that a system with a single Xeon host processor and a Xeon Phi 5110P card, has the same floating point performance as the ASCI Red supercomputer which topped the Top500 supercomputer list in 1999 and 2000.  The computing power of a US National Laboratory ten years ago, but it fits on your desktop.  

Naturally, I ordered exactly this configuration, and am waiting for [Puget Systems](http://www.pugetsystems.com) to deliver it this week or next.  The best part?  Right now, a developer program with Intel will get you a Xeon Phi 5110P (passively cooled) coprocessor card for less than $500, along with a year's license for the Intel compiler stack and cluster computing tools, which normally are fairly expensive (although in the same realm as __Mathematica__ for academic use).  The downside is that the passively cooled Phi cards need some extra cooling and good system design and testing, unless you simply want to cook a $4-5000 computer down to slag fairly quickly.  That's where Puget Systems and their expertise come in -- sizing the power, selecting and testing the cooling system, and making sure that you're good to go.  Even if you pay them a small premium for integrating the box, the work they're doing is impressive and I think it's going to be well worth it.  

How to use it?

### Improving Parallelism and Code Performance ###

The Phi can augment the host processor in several ways, since it runs a full (but basic) Linux distribution.  In "native" mode, you can compile code for the coprocessor, for example using OpenMP to parallelize tasks across the cores, and run code against 61 cores as long as the memory present on the Phi itself (8 or 12GB) is adequate.  Which it might very well be, for code which deals with small data (common in agent-based simulation models), but has complex branching structure or algorithms which run on each core.  

The second mode is "offload" mode, in which your code runs on the host processor, but certain operations can be parallelized onto the coprocessor for a boost.  Here's where it gets interesting.  It might be possible to offload directly from Python code, and to offload NumPy expressions directly to the Phi with the main program running on the host processor (or across many of the host cores).  NumbaPro and OpenCL are paths to this type of offloading, and even if not done explicitly, if your copy of NumPy is linked against the Intel MKL math libraries on Linux, offloading can be done at the library level even if Python is unaware of it.  
The latter offers the possibility of offloading work from libraries like scikit-learn for machine learning and statistical algorithms, even if the ML library itself is coprocessor-unaware.  

And if you use R, switch to the RevolutionR Open version of the runtime, which is linked against the Intel MKL math libraries.  Again, it may be possible to have R use the Xeon Phi coprocessor for algoritms which involve larger NumPy calculations without modifications to your R code. 

See, it's getting very interesting, isn't it?  

I'm not sure how much of this automatic offloading will work "off the shelf" from Python, but given NumbaPro from the Anaconda folks, I don't imagine it'll be long before all of it will. And *anything* you write in C++ can be made to use the coprocessor immediately, so compute-critical sections in your Python code can always be linked via Cython or SWIG.  

The future looks even more interesting.  The next generation of Phi chips starts shipping commercially in 2016, so I didn't go all out this time.  Next year, the "Knight's Landing" architecture will put the Phi in motherboard sockets, eliminating much of the time needed to move data over the PCI bus to the coprocessor card, and yielding a true 75 or 150 core server system.  Pair one of those systems with a box running 1 or 2 "normal" Haswell/Broadwell Xeon processors, and you've got a small 160-175 core cluster in the space it used to take for a couple of workstations.  

### Next Steps ###

So I'm bullish on the opportunity to drastically speed up cultural transmission simulations, seriation analyses, the use of "Approximate Bayesian Computation" for statistical inference on these complex models, and even phylogenetic analysis codes, in fairly short order.  

Which is good, because the social sciences are getting more and more computationally complex, and we have less and less funding for buying time on large clusters or renting time from major cloud services.  

I'll report back when I have some code up and running.  
