---
layout: project_layout
title: Coarse Grained Models of Cultural Transmission
tags: [cultural transmission, coarse graining, renormalization, time averaging]
date: 2013-05-28 00:00:00
---

## {{ page.title }} ##



<div id="home">
<h3>Project Description</h3>
</div>

Coarse grained models of cultural transmission are those which describe transmission with lower granularity than individual outcomes, summarizing the results of social learning over entire groups, larger blocks of geographic or social space, or aggregated over spans of time instead of making point observations.  A coarse grained model may also introduce observation units which are aggregates of the information actually passed by individuals during social learning.    

The classic modeling work by Boyd and Richerson, or Cavalli-Sforza and Feldman, is comparatively "fine-grained," in that models describe stable equilibria achieved in comparatively short time intervals, with observations made upon individuals and their traits.  The observed traits, in a fine-grained model, are the same units of information which are copied and imitated by individuals.  

Fine grained models form the basis for nearly all archaeological discussion of CT today, despite the fact that archaeologists deal with a highly aggregated, often "time averaged" record of past artifactual discard and human behavioral traces.  Several decades of formation process studies, taphonomic studies of a variety of materials and artifact classes, and a growing appreciation of the limits that the sedimentary record places upon the questions we can ask (i.e., "time perspectivism") should be informing our efforts to adapt fine grained cultural transmission models to archaeological use, but to date they have not.  

I am engaged in a project to study the properties of common cultural transmission models as we "coarse grain" them in various ways:

* temporal aggregation
* spatial or population aggregation
* classificatory aggregation of observation units
* all of the above, since this is what we see in in the empirical record.



<div id="home">
<h3>Deliverables</h3>
</div>

This project forms the basis of my Ph.D. dissertation research at the University of Washington.  The results of these researches will be released in the form of 3-4 published or in press papers, along with a dissertation document outlining the background for the research and research methods.  

One paper, an initial examination of temporal aggregation or "time averaging" upon the classic neutral model adapted by Neiman from Sewall Wright, Motoo Kimura, and others, has been submitted to the _Journal of Anthropological Archaeology_, and was presented at the 2012 meeting of the Society for American Archaeology.  [preprint](http://arxiv.org/abs/1204.2043v2)

<div id="home">
<h3>Project Notes</h3>
</div>

<ul class="posts">
{% for post in site.categories["coarse grained model project"] %}
         <li><a href="{{ post.url }}">{{ post.title }}</a>  <span class="index_publish_date">{{ post.date | date_to_string }}</span></li>
{% endfor %}
</ul>





Tagged
------
<div class="taglist">
{{ page.tags | array_to_sentence_string }}
</div>


<div class="project_publish_date">
{{ page.date | date_to_string }}
</div>

















