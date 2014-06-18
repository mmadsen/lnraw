---
layout: default
title:  How the Lab Notebook Works
---
<div class="span9">

## About This Notebook ##
This lab notebook is built on top of [Github](http://github.com/), using the [Jekyll](http://jekyllrb.com) static website build system created by Tom Preston-Warner and others from Github and the open source community.   My requirements for the lab notebook are:

* The ability to write posts offline in a simple markup language, but publish the material in any set of formats I need
* The ability to host a production version of the lab notebook that the world can read on the web, and update it easily
* Easy embedding of bibliographic references, and the production of bibliographies for posts and articles
* The ability to link to articles and posts on the lab notebook with persistent URIs and clear bibliographic references, since this notebook is scientific research, and often will be the primary record of my work prior to its publication elsewhere.
* The ability to render math and software source code easily and in a typographically pleasing manner, _without_ turning such things into image objects in JPEG or PNM files.  

Previous attempts at these requirements always missed something.  Instiki satisfied most of these for several years, but the difficulty of finding an offline + hosted solution that didn't involve writing code and manually managing a hosted website account with all of Instiki's dependencies and a database engine caused it to never happen.  Wikispaces was a good online solution, with decent math, but no offline solution and no ability to write plugins to do the bibliographic bits easily.  

Carl Boettiger's [lab notebook](http://carlboettiger.info) intrigued me, and was built on Github Pages, so the hosting was included in my Github account already, and I could do "interesting" things with its underlying system.  It's been a journey, but I think I have a version figured out which is different from CB's, but workable given my needs.  Welcome to my lab notebook.  Here's how it works, if you want to do your own. 

### Overview ###
Github Pages allows one to host straight HTML or Github-flavored Markdown, or Jekyll-based Markdown, which is then turned into HTML.  For very good reasons, Github Pages disallows third-party Jekyll plugins, because that would be a massive trojan horse and performance disaster.  Bad juju.  

So the solution is that I have _two_ Github repositories for the lab notebook.  One is the "source code" for the lab notebook, where I write posts and test formatting, and do everything "offline" -- I compile it using a Rakefile and it runs on localhost.   When I'm happy, I commit the changes to git, and run a script which pushes everything to the live site.  More on this below under "Deployment".


### Notes, Essays, Categories, and Tags ###

Everything here is ultimately a "post," meaning that apart from site structure itself (which are often HTML pages with Jekyll/Liquid) tags, 
Javascript, and logic, everything is a Markdown file located in the "_posts" directory of the `lnraw` source repository.  

At a conceptual level, I distinguish between "essays" and "notes," in the following way.  A note is like a page in your lab notebook.  It records something useful (e.g., the setup of an experiment, ideas about fixing a problem, some results) but a note is not expected to stand alone without 
other context.  The context of a note is provided by the `project` it lives in, the `model` or simulation code it may relate to, perhaps an `experiment` within which the note is a step or result.  Each of these bits of metadata are recorded as a `category`, which Jekyll provides to 
break websites into logical units.  A note can (and almost always does) belong to more than one category.  For example, a recent note on planning an experiment for `ctmixtures` had the following header:

```
---
layout: post
title: Experiment Planning for CT Mixture Model
tags: [cultural transmission, coarse graining, simulation, dissertation, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model project
- model:ctmixtures
- experiment:experiment-ctmixtures
---
```

You'll see at the bottom of the YAML header, that this note belongs to `project:coarse grained model`, it relates to the model `model:ctmixtures`, and the ongoing experiment `experiment:experiment-ctmixtures`.  These categories are used by the website logic itself to build lists for project pages, experiments, and to list notes related to a given body of code.  

Essays, on the other hand, may be related to a specific project but are expected to be comprehensible in a standalone manner.  For example, a recent essay on "continuous integration" and Travis CI had this metadata:

```
---
layout: essay
title: Continuous Integration and Testing for Simulation Codes
tags: [experiments, simulation, open science, reproducible science]
categories:
- essays
- simulation
- reproducible science
---
```

This essay isn't related to any specific project or experiment.  The category "essays" will put it in the list of essays and general writings on the site.  Also note that I give the `layout` as `essay` here, which has minor UI tweaks compared to the lab note/post format.  It puts a link to the essay list in the upper toolbar, at the moment, which lab notes don't have because they are assumed to be cross-linked in all sorts of ways, with no 
obvious "back" button.  

Each posting also has a series of tags, which are wholly optional.  These are often related to topics, and represent another way to see content, via the tag cloud (Notes by Tag).  


Finally, the "byexperiment" page (and eventually, other lists) are all built from custom Liquid filter tags which can pull out and make nice lists
of posts from experiments, models, or projects.  The source (and executable) for this Liquid filter is located in the `_plugins` directory.  At the 
moment, the "bymodel" page is not fully automatic, because I put the Github repository links on each model.  




### Documentation ###

* [Adding a Project](/doc/adding-project.html)
* [Adding an Experiment](/doc/adding-experiment.html)

I also have a few small shell scripts which make it easy to start a new note or essay.  `newlabnote.sh` copies a template Markdown file,
with the proper YAML header, to a date-stamped file with the current date, in the `_posts` directory of the lab notebook's source directory.  `newblogpost.sh` does the same thing with an essay template.  For example, starting a new note about the `seriationct` project, I type:

```
mark:_posts/ (master*) $ newlabnote.sh seriationct-requirements                                                                                                                                        [13:15:00] Creating lab notebook post for: 2014-06-17-seriationct-requirements.md
```

This helps me get the categories, tags, and layout right since they're important to how the site is organized.  

### Deployment ###

When I'm ready to push a note or some edits to the live website, the `Rakefile` in the source tree takes the following steps:

1.  Changes to the local source tree are checked into Git, into the local repository.
1.  The local source repository is pushed to Github (into the source version of the website), so we have a record of each change.
1.  Jekyll then builds the new version of the static website, from the local source into a local "_site" directory, which contains the entire website.  
1.  This built website is then copied to a directory which contains the "production" version of the website locally.
1.  That production version is then checked into the "production" repository in Github, and pushed to Github.  This repository is my Github Pages repository, so anything I push there is served as a static website.

That's it.  Takes about 60 seconds to push everything on a reasonably slow connection, and when I'm done both the source and the production site are version controlled.  I can go back to work locally at this point.  



### Details ###

The site uses Jekyll at whatever its current release is.  I only modify Jekyll by upgrading it, or adding plugins.  When you upgrade, pay attention to updates for Jekyll Scholar dependencies, and in particular the `csl-styles` package, which hasn't necessarily come along for the ride in the past and can cause errors.  It updates just fine via the normal Ruby `gem` mechanism, but you may have to do it manually. 

I also use [Bootstrap](http://twitter.github.com/bootstrap/) as the CSS and layout engine for the site.  Bootstrap is superb and allows a flexible gridding system for easy layout, has terrific pre-defined styles for buttons, menus, and a ton of small icons for common UI design tasks.  If you're not using Bootstrap, check it out.  It's one of Twitter's great gifts to the software community, along with Storm.  

In addition, I use several plug-ins to Jekyll:

* **Jekyll-Scholar**:  I use this only to assemble my CV publication list, from a set of BibTeX files that have references for articles, book chapters, in press materials, and conference papers.  The plugin is terrible for doing references in postings, but it's great for rendering a bulk bibliography from a BibTex file, so I feel no need to use the normal Pandoc citation mechanism to build my publications list.  
* **jekyll.tag_cloud**:  This builds a tag cloud for my tags page, but I've modified it locally to link to my directory structure.  
*  **greycite_biblio**:  a plugin I wrote to produce a persistent bibliographic reference to each notebook page, using metadata embedded in the Jekyll templates and [Greycite](http://greycite.knowledgeblog.org/), which catalogs generic URIs for research citations.  This plugin is available at my [Github repository](http://github.com/mmadsen) and is open source software.
* **git_modified**:  a plugin borrowed from Carl Boettiger, for looking at the Github/Git modification time for a file, and using that to set a Liquid/Jekyll variable for the last modification time.  I use this in the header of every 
notebook post to indicate the difference between when a post was originally written, and last modified. _
* **postcategory_filter.rb**:  a small Liquid filter plugin I wrote to filter posts in various ways by category.  This is currently used on the main page to produce "notes" versus "essays".  

### Pandoc ###
I have also replaced the default Markdown parser (and its supported alternatives) with [Pandoc](http://johnmacfarlane.net/pandoc/).  Pandoc is a generic document conversion utility, written in Haskell, and I have a plug-in, borrowed originally from Carl Boettiger but modified slightly, to generate appropriate links for my website.  It does a superb job of translating Markdown _with bibliographic citations to BibTeX files_ to HTML5 with a full bibliography in Chicago author-date format.  

In addition, I have templates for writing RMarkdown, with embedded R language code, and using [Knitr](http://yihui.name/knitr/) to produce either plain Markdown with source code annotations, or full LaTeX files.  This allows reproducible research results on the lab notebook and an easy transition to journal articles.  With bibliographies, source code, results, tables, and figures.  Nice.  

The only thing Pandoc isn't good at is handling _big_ bibliography files, since it does a file scan _per post_.  This is a known issue, and a 1000+ citation file basically bogs down the site build to unusability.  100+ is fine, with a small but noticeable build time.  Sometime in the next year, I'll write a build script adjunct that pulls out citations, builds a per-post subset BibTeX file, and feeds it to Jekyll, but I need to know more about Jekyll's core before I do that.  

### Summary ###
All of this is open source, and the [source to my lab notebook](https://github.com/mmadsen/lnraw) is available on Github.  Grab it, wipe out my posts, install Jekyll, Pandoc, and whatever Ruby dependencies it all needs, and go to town.  The layouts need some editing, and the config.yml file, and some other bits, but you should have this up and running within an hour or two.  Email me if you need to, and I'll provide guidance.  









</div>
