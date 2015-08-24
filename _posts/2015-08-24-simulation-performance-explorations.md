---
layout: essay
title: Improving Simulation Performance for CT Models
tags: [cultural transmission, simulation, computing, HPC, computational science]
categories: 
- essays
---

### Background ###

A side project this summer has been to improve the performance of my basic simulation model codes, so I can increase my experiment "velocity" and do more analyses with larger sample and/or population sizes.  Since getting a Xeon/Phi workstation (the machine I [described a few months ago](/essays/2015/07/07/new-directions-ct-computing.html)), I've been retraining on C++11 for situations which call for mixed Python/C++ performance, or for all C++ simulations when I can't figure out a good offload or parallelism model for Python code.  At the moment I'm using a pure C++ simulation of the Wright-Fisher neutral model, with infinite-alleles mutation on several loci for my testing.  The [simulation code is available here](https://github.com/mmadsen/neutral-model-cpp) with Makefiles for several compilers, including clang (i.e., modern OS X), GCC 5.2 (which has first-gen support for compiling offload for the Xeon Phi coprocessors), and the Intel C/C++ compiler.  (Mental note, I should include a plain vanilla Makefile which would use which ever "GCC" is present...).

These notes describe what I've found so far about improving performance in this code.  

### Implementation Notes ###

The simulation model is (hopefully) designed to allow for both parallelism across cores/threads, and for use of the Intel Xeon's native (and considerable) vectorization infrastructure.  

1.  The "population" is represented by an array of size numloci columns by popsize rows, with integers representing trait ID's.  This block is allocated a single linear block, and at least on the Intel compiler is 64-byte aligned to maximize use of the wide vectorization units (and the even wider ones on the Phi).

2.  This creates "unit stride" access for many common operations, like calculating trait counts.  

3.  Complex operations like calling the C++11 random number library are extracted from nested loops and done separately, to allow the results of random number generation to be used in loops which are then parallelized AND vectorized.  

4.  OpenMP is used to parallelize nested loops for actual trait transmission.  

5.  Explicit vectorization via `#pragma SIMD` is forced in a couple of places where the compiler cannot necessarily figure out the loop count easily.  

### Test Setup ###

The resulting program, `neutral-test`, is called as follows to generate timing and performance information:

`export OMP_NUM_THREADS=4; time ./neutral-test --popsize 10000 --numloci 5 --inittraits 6 --innovrate 0.0001 --simlength 25000 --debug 1 --ruletype wfia`

The population size is large enough to generate opportunities both for vectorization and effective use of OpenMP parallel for loops, and the simulation length is long enough to create stable timing.  

### No Optimizations ###

If we turn off all optimizations (using `-O0 -no-vec` and not passing `-openmp` to the Intel compiler), we get the straight line, single core, un-vectorized performance:

```
real    0m42.556s
user    0m42.176s
sys     0m0.178s
```

We can see that the vast majority of time is spent in user code, mostly in tight loops, or in the C++11 library (which isn't kernel code), and that kernel code occupies a tiny fraction of execution time (mostly some I/O at the beginning and end since I have logging turned way down).  Real time and user time is basically the same, showing that we are totally single-threaded.  

### Vectorization Without Parallelism ###

If we turn off OpenMP parallelism, but enable vectorization and aggressive compiler optimization (`-O3`), we see dramatic improvement:

```
real    0m11.765s
user    0m11.666s
sys     0m0.045s
```

This is a speedup of 3.62x, simply by allowing the compiler to vectorize code in a situation where memory access has been designed for easy vectorization (i.e., unit stride access).  

### Parallelism Without Vectorization ###

If we enable OpenMP parallelism but turn off vectorization, we allow the use of multiple cores for copying tasks, although by the nature of this code base not all loops should be handled in parallel.  The code is compiled with `-O3 -openmp -no-vec`.  

```
real    0m10.370s
user    0m39.686s
sys     0m0.918s
```

Here we get 4.1x speedup, and we can see the effect of parallelism, where the user portion of code executes for 3.9x the wall clock time.  So there is real benefit from parallelism here, and I'm exploring whether more of the loops can be parallelized.  

### Parallelism and Vectorization ###

Finally, I enable everything (`-O3 -openmp`):

```
real    0m10.211s
user    0m39.313s
sys     0m0.811s
```

The improvement with both is tiny over either approach alone.  I need to investigate the reasons for this, but a hotspot analysis with Intel's Vtune Amplifier XE profiler showed that the code, at this point, is constrained mainly by the speed of random number generation, not my copying or mutation code.  

What surprised me in this analysis wasn't the performance of paralellism (with or without vectorization), but the near equivalent performance of **just vectorizing** the code.  This suggests that instead of spending a lot of time working on parallelism, I could just ensure that code was vectorizing sufficiently, and then use many cores to run many processes representing many parameter sets, to add a huge factor to overall experiment throughput.  



