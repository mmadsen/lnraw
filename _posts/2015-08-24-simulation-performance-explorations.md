---
layout: essay
title: Improving Simulation Performance for CT Models with C++ and OpenMP
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

The improvement with both is tiny over either approach alone.  But this may be due to the small problem size.  

### Population Size 100,000 ###

If we switch to a larger population size, here are the results:

```
No optimization - 6m38.924s

Vec w/o Parallelism  - 2m4.405s

Parallel w/o Vec   -   1m54.437s

Vec and Parallelism  - 1m36.847s
```

Here we see the separate contributions of vectorization and parallelism.  The overall speedup is constant at 4.1x for both parallelism and vectorization, but this speedup is only achieved by having both.  With the larger problem size, vectorization alone achieves a 3.2x speedup, and parallelism alone about 3.5x.  As problem size grows, the importance of combining both approaches only grows (an intermediate problem size of 50K population size has intermediate results, for example).  

The biggest challenge in optimizing this kind of simulation code, it seems, is handling random number generation, which now seems to be the major hotspot.  It is also complex enough that including a random generator call in a loop is sufficient to disqualify the loop from vectorization.  It is also not clear whether it is safe to use the C++11 random library from multiple threads without locking, and introducing explicit thread-local generators obviates some of the benefit of having OpenMP automatically do thread management and decide the optimal threading strategy.  

The obvious way around this is to generate pools of random variates before going into a loop nest, so that the random variates are simply an array access like any other and thus can be used in vectorized, OpenMP parallelized loops.  The current code reflects this strategy for determining the individuals who will be cultural models (targets of copying) in each generation.  


### Parallelized Random Number Generation ###

Creating 100K random variates is still a fairly time-consuming step, and this may be an area where using a GPU (if available) is a good idea, since at least CUDA (if present) has a high performance random number library.  I hate to have hardware-specific code, though, especially if Apple moves away from NVIDIA cards in the Macbook Pros, which makes it hard to develop while mobile or away from home.  

There's no good reason why I shouldn't be able to parallelize random number generation using OpenMP, however, as long as each thread has its own private engine variable, which is accomplished by initializing the engine and distributions inside the parallel region, instead of during object construction:

```c++
#pragma omp parallel shared(test_par)
{
        std::random_device rd;
        std::mt19937_64 eng(rd());
        std::uniform_int_distribution<int> uniform_int{0, test - 1};
        num_threads = omp_get_num_threads();

        #pragma omp for
        for(i = 0; i < test; i++) {
                test_par[i] = uniform_int(eng);
        }
}
```

The result with 100K individuals and 25K generations (comparable to the above timing experiments) is:

```
31.24 real       119.92 user         3.02 sys
```

which is a 12.76x speedup over the serial unvectorized code.  I'm not likely to push the performance experiments too much further, since I have a lot of other code to write, but it was a good experiment and now I have code modules to use in future simulations where I need the performance.  And, others are encouraged to start with it and adapt it to your own transmission simulations, since it's known to work and work quickly.











