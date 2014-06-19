---
layout: post
title: Issues with Tree Structured Axelrod
tags: [SAA2014, axelrod model, structured information, cultural transmission, dissertation,experiments,  experiment-semanticaxelrod]
categories: 
- project:structured information
- model:axelrod-ct
- experiment:experiment-semanticaxelrod
---

### Issues ###

Currently, the tree structured model is implemented as follows:

1.  Individuals have unstructured sets of traits
1.  Traits are derived from structured trees
1.  There are multiple trees, giving a "forest" for a trait space
1.  Each trait tree has identical branching factor and depth (for the moment)
1.  Individuals are initialized with random traits and their prereqs in the tree

Given this infrastructure, the copying rule is a modification of the extensible model:

```python
f = getRandomAgent()
n = getRandomNeighborForAgent(f)

if n = f or n.isdisjoint(f) or n.issubset(f):
	exit  # no interaction possible

prob = jaccardIndex(n,f)
if RandomUniform() < prob:
	traits = neighbor.get_differing_traits(agent)
	neighbor_trait = random.choice(traits)

	if f.hasPrerequisitesForTrait(neighbor_trait) == False:
		exit # cannot copy the trait, does not have prereqs

	f.add_or_replace(neighbor_trait)
```

The behavior of the model is problematic, although I'm reasonably sure it's structural and not simply a bug.  The active link density will initially decline, and then stick at a high level for as long as I'll watch it (i.e., a million or so cycles).  Watching the cumulative number of copying events reveals that quickly, the rate of successful interactions goes to zero.  

This probably occurs because the convergence algorithm sees plenty of active links (indeed, almost all links are "active") but after a few passes, no agents have the prerequisites for each other's differing traits.  Clearly, the copying rule needs work.  

### Revised Prerequisite Rule ###

To work, there needs to be a probability of learning a missing prereq.  Perhaps this substitute for the "addition rate," which was pretty artificial.  

One possibility:

```python
f = getRandomAgent()
n = getRandomNeighborForAgent(f)

if n = f or n.isdisjoint(f) or n.issubset(f):
	exit  # no interaction possible

prob = jaccardIndex(n,f)
if RandomUniform() < prob:
	traits = neighbor.get_differing_traits(agent)
	neighbor_trait = random.choice(traits)

	if f.hasPrerequisitesForTrait(neighbor_trait) == False:
		if RandomUniform() < learning_rate:
			needed_prereq = DeepestRequiredPrerequisiteOf(neighbor_trait)
			f.add(needed_prereq)
	else:  # has prereqs
		f.add_or_replace(neighbor_trait)
```

