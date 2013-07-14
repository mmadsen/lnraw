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

So the solution is that I have _two_ Github repositories for the lab notebook.  One is the "source code" for the lab notebook, where I write posts and test formatting, and do everything "offline" -- I compile it using a Rakefile and it runs on localhost.   When I'm happy, I commit the changes to git, and then compile the finished site, which I then copy to a second Github repository for Github Pages, which contains only the finished HTML, CSS, Javascript, and other assets.  This repository, when pushed to Github, becomes the public website.  All of this is automated by a build script (i.e., Rakefile), of course, so when I check in a post to the "source" repository, it's a matter of moments before it's built, copied, checked in, and pushed live.  And both repositories are version controlled, so you have version-controlled source and production files.  Nice.  

### Details ###

The site uses Jekyll at whatever its current release is.  I only modify Jekyll by upgrading it, or adding plugins.  

I also use [Twitter Bootstrap](http://twitter.github.com/bootstrap/) as the CSS and layout engine for the site.  Bootstrap is superb and allows a flexible gridding system for easy layout, has terrific pre-defined styles for buttons, menus, and a ton of small icons for common UI design tasks.  If you're not using Bootstrap, check it out.  It's one of Twitter's great gifts to the software community, along with Storm.  

In addition, I use several plug-ins to Jekyll:

* **Jekyll-Scholar**:  I use this only to assemble my CV publication list, from a set of BibTeX files that have references for articles, book chapters, in press materials, and conference papers.  The plugin is terrible for doing references in postings, but it's great for rendering a bulk bibliography from a BibTex file, so I feel no need to use the normal Pandoc citation mechanism to build my publications list.  
* **jekyll.tag_cloud**:  This builds a tag cloud for my tags page, but I've modified it locally to link to my directory structure.  
*  **greycite_biblio**:  a plugin I wrote to produce a persistent bibliographic reference to each notebook page, using metadata embedded in the Jekyll templates and [Greycite](http://greycite.knowledgeblog.org/), which catalogs generic URIs for research citations.  This plugin is available at my [Github repository](http://github.com/mmadsen) and is open source software.
* **related_posts**:  a plugin borrowed from Carl Boettiger, for creating related posts which are related to tags present on the post itself, rather than whatever bogus algorithm ships with Jekyll.  
* **git_modified**:  a plugin borrowed from Carl Boettiger, for looking at the Github/Git modification time for a file, and using that to set a Liquid/Jekyll variable for the last modification time.  I use this in the header of every 
notebook post to indicate the difference between when a post was originally written, and last modified. _

### Pandoc ###
I have also replaced the default Markdown parser (and its supported alternatives) with [Pandoc](http://johnmacfarlane.net/pandoc/).  Pandoc is a generic document conversion utility, written in Haskell, and I have a plug-in, borrowed originally from Carl Boettiger but modified slightly, to generate appropriate links for my website.  It does a superb job of translating Markdown _with bibliographic citations to BibTeX files_ to HTML5 with a full bibliography in Chicago author-date format.  

In addition, I have templates for writing RMarkdown, with embedded R language code, and using [Knitr](http://yihui.name/knitr/) to produce either plain Markdown with source code annotations, or full LaTeX files.  This allows reproducible research results on the lab notebook and an easy transition to journal articles.  With bibliographies, source code, results, tables, and figures.  Nice.  

The only thing Pandoc isn't good at is handling _big_ bibliography files, since it does a file scan _per post_.  This is a known issue, and a 1000+ citation file basically bogs down the site build to unusability.  100+ is fine, with a small but noticeable build time.  Sometime in the next year, I'll write a build script adjunct that pulls out citations, builds a per-post subset BibTeX file, and feeds it to Jekyll, but I need to know more about Jekyll's core before I do that.  

### Summary ###
All of this is open source, and the [source to my lab notebook](https://github.com/mmadsen/lnraw) is available on Github.  Grab it, wipe out my posts, install Jekyll, Pandoc, and whatever Ruby dependencies it all needs, and go to town.  The layouts need some editing, and the config.yml file, and some other bits, but you should have this up and running within an hour or two.  Email me if you need to, and I'll provide guidance.  









</div>
