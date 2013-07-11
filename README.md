# lnraw - Lab Notebook Source Version #

Mark Madsen's lab notebook is hosted at Github Pages, and is built from this repository using Jekyll.  This document records the structure of the notebook source, and build system.  

## General Notes ##

The lab notebook is written in a combination of Jekyll HTML templates (with Liquid tags), and posts which are written in the [Pandoc](http://johnmacfarlane.net/pandoc/) dialect of Markdown.  The CSS system in use is Twitter Bootstrap, given the nice fluid grid system.   Pandoc was chosen because it natively handles bibliographic citations, and most of the Jekyll plugins for this were highly limited in functionality.  

## Directory Structure ##

_includes
:    not currently used, but intended for repeating chunks of code or boilerplate  

_layouts
:    HTML templates which Jekyll uses.  *default.html* is the skeleton for all pages on the site, using Twitter Bootstrap 
      to establish the grid system with left sidebar and main content area.  The project pages use a slightly different 
      template to ensure that the content doesn't spill over into the left sidebar area.  
      
 _plugins
 :    Ruby code plugins for Jekyll processing.  The publications page uses the Jekyll-Scholar plugin even given Pandoc
       because the plugin makes it simple to use multiple bibliography files and produce a bibliography from all citations
       in the file, without having to maintain individual citations in the text.  This automates a CV/vita style listing of 
       publications without having to keep files and cite keys in sync.  Other plugins in use are a pandoc_markdown 
       converter, a tag cloud plugin, and Carl Boettiger's plugin for retrieving modification dates for files from Git.  
       
 _posts
 :      Contains raw Markdown source for lab notebook posts, which are treated as if they are blog posts.  These 
       Markdown files can contain bibliographic citations in the Pandoc format [@citekey], which are rendered
       into a Chicago author-date referenced cited list at the end of the post (so most post sources end with an H3 
       introducing "References Cited."  The post template in the layout directory is responsible for adding tag links
       and a modification date to the post itself.  
       
  :      A subdirectory, *source*, is used for posts that will be pre-processed by Knitr.  Rmarkdown formatted files
        are kept here, processed via a Knit script (by Carl Boettiger), and the resulting Pandoc markdown is then moved 
        into the main _posts directory for Jekyll to build as normal.  This is only required for Knitr/R processing; other 
        non-executed source code chunks (e.g., some Ruby code chunks) are simply embedded in normal Markdown 
        source.
        
 assets
 :      The assets directory houses CSS, Javascript, small icons, and other resources referred to by the layout templates.  
       Much of this directory is simply copied from a Twitter Bootstrap implementation, unmodified.  
       
css
:       **DEPRECATED** contains legacy CSS files from the first version of this labnotebook, prior to redesign with
       Twitter Bootstrap.  Should be removed from the current HEAD of the master in Github, once I'm satisfied there
       are no dependencies and I'm not rolling back.
       
images
:      User-created image content, linked into the lab notebook pages via normal Markdown or HTML image links.  This 
       is where graphics or other images are placed for a post or project.  
       
files
:      Directory for housing other downloadable objects, such as R source code files, PDFs linked on the site, etc.  

projects
:      Holds subdirectories describing research projects.  Each subdirectory has an index.html using the project layout
       template, which describes a research project, and has Liquid tags generating a listing of related posts and lab
       notebook pages.  These pages change only when a project description is updated.  
       
Rakefile
:      Building the system is done via a Rakefile, so "rake build server" cleans out the _site directory into which Jekyll
       builds the website, rebuilds everything, and deploys it to a development server on **http://localhost:4000**.   
       To push the current development snapshot to Github Pages, "rake deploy" runs the "lnbuild" script in 
       Dropbox/Research/bin.  
       
_config.yml
:      Jekyll configuration file, which currently configures for pandoc as the Markdown parser, adds Jekyll Scholar
       for producing the publications.html page from a template version in the main directory, and adds the tag cloud
       Liquid tag for use on the tags.html page.   







