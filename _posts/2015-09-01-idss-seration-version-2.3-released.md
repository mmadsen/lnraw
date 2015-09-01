---
layout: post
title: IDSS Seriation Software Version 2.3 released
tags: [cultural transmission, coarse graining, seriation]
categories: 
- project:coarse grained model
---

Today, Carl Lipo and I released [Version 2.3](https://github.com/clipo/idss-seriation/releases/tag/v2.3) of our [IDSS seriation software](https://github.com/clipo/idss-seriation), described in our [recent PLoS One article](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0124942).  

This version contains:

1.  A bug fix for a triple ordering issue found by [Xavier Rubio-Campillo](http://bsc-es.academia.edu/XavierRubio) of the Barcelona Supercomputing Center (thank you, Xavi!).  We did not incorporate his full pull request, since we are undecided about some of the changes, but did integrate this fix.
1.  A performance rewrite of the spatial/geographic significance bootstrap test, which improved the average runtime of this test about 4.5x (which helps with larger numbers of assemblages).
1.  Every run now gets a UUID and is associated with the release tag and Github commit identifier, to allow results to be tracked to specific software commits, not just periodic numbered releases.
1.  UUID and software commit identifiers are written to a "metadata" file in the output directory, and to the database if you use the MongoDB driver script.
1.  The pickled temporary directory (used for parallel processing) is now written in /tmp for convenience, and unless you specify --preservepickle 1, it is cleaned up at the end of the seriation run.  This yields a cleaner setup for batch processing. 

The easiest way to try out the software is to grab the source for the PLoS One article, which contains the data and a Makefile for regenerating our seriation output:

```shell
$ git clone git@github.com:clipo/idss-seriation.git
...ignoring lines...
$ cd idss-seriation
$ python setup.py install
$ cd ..
$ git clone git@github.com:mmadsen/lipomadsen2015-idss-seriation-paper.git
$ cd lipomadsen2015-idss-seriation-paper/seriation-analysis
$ make
```

You should see output that looks like this:

```shell
IDSS seriation Version 2.3
2015-09-01 14:56:37,451 INFO: seriation run identifier: urn:uuid:5183fa22-50f4-11e5-959b-b8f6b1154c9b
Bootstrap CI calculation using 1000 samples - elapsed time: 0.037674 sec
Time elapsed for frequency seriation processing: 28 seconds
Seriation complete.
Maximum size of seriation: 3
Number of frequency seriation solutions at last step: 1139
Assemblages not part of final solution:
*** All assemblages used in seriations.***
Time elapsed for completion of program: 83 seconds
```
and several graph windows will pop up.  The "minmax" graph shows the best solution with branching to show how different partial seriations relate.  There will be an "output" directory with full output.  

Please contact me or Carl Lipo if you have questions about IDSS and this release!