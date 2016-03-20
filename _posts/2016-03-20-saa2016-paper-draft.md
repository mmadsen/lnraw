---
layout: essay
title: Paper for SAA 2016 - Measuring Cultural Relatedness Using Multiple Seriation Ordering Algorithms
tags: [SAA2016, seriation, cultural transmission, dissertation]
categories: 
- essays
---

The Society for American Archaeology meetings are coming up in Orlando, and I'll be participating in a session called:

> Evolutionary Archaeologies:  New Approaches, Methods, and Empirical Sufficiency

along with a number of colleagues.  We opted for the "electronic symposium" option this year, which is a slightly confusing description.  Instead of presenting or reading a full paper, we submit papers in advance, which are posted online (the "electronic" part).  At the conference, we each get a few minutes to re-summarize our work for the audience to ensure that everyone is up to speed, and then we have Q&A and discussion for most of the time.  

I argued for this format because with standard symposia, there are rarely many questions giving the time constraints, and never any discussion.  And by the time you're standing around afterwards in the hotel bar with the other participants, the discussion is all about jobs and teaching and the terrible state of science funding, etc.  So we're doing this as an experiment to see what happens when we get more time to talk, both amongst ourselves as researchers, and to folks who might be interested but not yet active participants in evolutionary analysis.  

My paper, with Carl Lipo, is an outgrowth of our research on new seriation algorithms, and explores the central place the unimodality principle has, and alternatives which are easier to ground in theory and are applicable to a wider class of data.  And, of course, when used on data that unimodality can handle, gives the same answer.  We explore using an exact algorithm for distance minimization which creates graphs rather than linear orders, and thus incorporates the effects of space as well as time directly, rather than treating departures from linearity as "error" or "noise."  The algorithm is already embedded in our IDSS seriation software as the "continuity" seriation option.  [Abstract here](http://notebook.madsenlab.org/essays/2015/09/06/saa2016-abstract.html)

You can read the [conference draft of our paper from the Github repository](https://github.com/mmadsen/saa2016-multiple-seriation-algorithms/blob/master/pdf-drafts/saa2016-seriation-multiple-approaches.pdf).  Comments welcome; this will be submitted for publication in the next few months so any suggested improvements are greatly appreciated.  We will likely incorporate several other data examples in the final version after getting permission from the folks who collected the data sets.  








