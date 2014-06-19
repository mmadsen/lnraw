---
layout: post
title: Research Design for Semantic Axelrod Model
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod, blogarch]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Semantic Axelrod as a Graph Problem ###

Standard CT models with unstructured, "tokenized" traits have two main components:  copying relations between agents, and the resulting frequency distribution of traits.  We manipulate the structure of the copying relations, and observe the consequences for the FD of traits.  Optionally, the FD of traits may be used to alter the copying relations, as in the original Axelrod model (and more recent models by Nowak's group and the "adaptive coevolutionary networks" reviewed by [@Gross:2008p19305]).  

When we add "semantics" (or more abstractly, structured relations between traits) to our CT models, we have the following components.  Not all of the components need be present in each model, of course:

1. Structured copying relations between agents, factoring in structure among traits
1. Map between agents and traits
1  Structured relations between traits, either fixed or evolving

If our goal is to implement a notion of `homophily` which includes trait relations rather than just quantitative overlap in trait possession, we can represent these components as three graphs, or instead, as a single multigraph.  

One graph is bipartite, mapping agents to concepts.  The measure of edges over the concept nodes is, of course, the frequency distribution of concepts (or traits).  

A second edge type is among agents, and describes "neighbors" which are allowed to observe and copy one another.  In an Axelrod model, we break these edges when individuals fall below a homophily threshold and no longer copy from one another.  In the situation where an Axelrod model fragments into "cultural domains," this is represented by the loss of global connectivity in the graph constructed by these edges, resulting in a number of separate components.  

A third edge type is among concepts, and describes some type of "semantic" relationship between concept.  Such edges might be directed, and could be fixed or evolving.  In this initial exploration, we will set concept relationship edges as fixed in each experimental run.  Thus, concept edges become input to the homophily algorithm, and thus feed into the breakage or maintenance of agent-agent edges.  
The overall problem is thus one of allowing the model to reach equilibrium (or quasi-stationary state), and then analyzing the characteristics of the concept subgraphs pointed to by the agents in each disconnected agent domain.  


### References Cited ###








