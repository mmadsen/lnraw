## provide the Jekyll name of the page or post, e.g. 2013-02-02-notes.md
## Makes this data available as if it was given in the yaml header, 
## e.g. we can use `page.path` in Liquid filters and tags to access this name


module Jekyll
  class PagePathGenerator < Generator
    safe true
    ## NOTE: post.dir gives the published directory path, e.g. 2013/02/02/ 
    # and post.base not valid  
    def generate(site)
      site.posts.docs.each do |post|
        post.data['path'] = post.basename
      end
      site.pages.docs.each do |post|
        post.data['path'] = post.basename
      end
    end
  end
end
