---
layout: post
title: Temporal Networks in SeriationCT
tags: [cultural transmission, coarse graining, simulation, dissertation, seriation]
categories: 
- project:coarse grained model
- model:seriationct
- experiment:experiment-seriationct
---

### Overview ###

In my [description of the SeriationCT model](/project:coarse%20grained%20model/model:seriationct/experiment:experiment-seriationct/2014/06/17/seriationct-requirements.html), I refer to controlling the connections and interaction intensity between communities by a diachronic "regional interaction model."  This note formalizes the way I handle specifying such models, using one type of "temporal network" formalism [@holme2012temporal].  

Two types of temporal network model are in general use today.  The first records the time at which events occur, where events are represented by the appearance and deletion of edges between vertices.  Such "instantaneous" temporal networks are useful for modeling time series data for events whose duration is small compared to the overall dynamics.  Examples include text messages between individuals or conversations at a party.  The second type of temporal network model (an "interval" network) records the pattern of vertices and edges over __intervals__.  During each interval, the adjacency matrix is assumed to be static, changing at specific time indices.  This type of model is represented by an integer-indexed sequence of full adjacency matrices, and is useful for representing an evolving situation or context upon which some __other__ dynamics plays out.  In other words, interval networks are perfect for representing ongoing CT in a more slowly changing context of local community formation, contact, isolation, and abandonment.  

![Figure 1: Toy model of a temporal network.](/images/ctseriation-temporal-network.png)

In Figure 1, I show only four vertices, to clearly demonstrate the implementation of a temporal network.  Vertices here represent local communities or demes, edges ($e_{i,j}$) represent interaction (e.g., intermarriage, trade, or other contacts resulting in opportunities for social learning), and the thickness of the edge is a graphical depiction of edge weights ($w_{i,j}$) which is an ordinal measure of interaction intensity.  Vertex pairs without a connecting edge are assumed not to be interacting during the time interval represented by the adjacency matrix.  

The figure represents a pattern of connections (at time $t=4$, say), and then a change at $t=11$ to increase the intensity of interaction or learning between communities 2 and 3.  This interaction declines to similar levels as other pairs of communities at $t=18$, but interaction between communities 3 and 4 increases.  Finally, at $t=25$, community 1 is abandoned, with no other changes in the interaction pattern.

These changes are reflected in the sequence of adjacency matrices below, by the change in off-diagonal edge weights.  Diagonal elements are used here to indicate the __existence__ of a population, and thus we mark the loss of community 1 by a zero in the upper left diagonal position of the matrix (naturally, its off diagonal elements go to zero as well).  

The full model is thus a sequence of tuples of the form $(t_0, A(t_0)) \ldots (t_i, A(t_i))$.  


### References Cited ###

