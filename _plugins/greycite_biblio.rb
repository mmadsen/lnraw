module Jekyll

  #Jekyll plugin to generate a link to the Bibtex metadata held by Greycite for this URI.
  #If Greycite has never seen this URI before, it will process the URI first, and then return.
  #
  #There is an advantage to walking the site and pre-inserting everything in Greycite, so the
  #greycite-walk.rb script is designed to be called during the process of pushing the labnotebook
  #content to the Github Pages server.  But this is merely pre-caching the data, and is not
  #strictly necessary.
  #
  # Usage:  {% greycite_bib_link type: bib %}  or  {% greycite_bib_link type: ris %}
  #
  # Both usages can be employed on the same post or page, to give a bibtex and ris citation link
  # on the same URI.  No formatting other than an HTML anchor link is returned, although the
  # links all open in a new tab or window, depending upon browser settings (target = _blank).
  #
  # Mark E. Madsen
  # (c) 2013
  #
  # Licensed under the Apache Software License, version 2.0  http://www.apache.org/licenses/

  class GreyciteBiblio < Liquid::Tag
    safe = true
    attr_reader :type

    def initialize(name, params, tokens)
      # initialize default value
      @type = 'bib'

      # Readable name for formats
      @type_names = Hash.new("UNKOWN TYPE")
      @type_names['bib'] = "BibTeX Entry"
      @type_names['ris'] = "RIS Citation"

      # process parameters
      @params = Hash[*params.split(/(?:: *)|(?:, *)/)]
      @type = @params['type'].strip
      super
    end

    def render(context)
      # greycite query URL
      greycite_url = 'http://greycite.knowledgeblog.org/'
      greycite_url << @type
      greycite_url << "/?uri="

      page_partial_uri = context.environments.first["page"]["url"]

      site_uri = context.registers[:site].config['url']
      full_url = "http://"
      full_url << site_uri
      full_url << page_partial_uri

      final_url = greycite_url
      final_url << full_url

      readable_type_name = @type_names[@type]

      html = "<a href="
      html << final_url
      html << " target='_blank'>"
      html << readable_type_name
      html << "</a>\n"

      html
    end




  end
end

Liquid::Template.register_tag('greycite_bib_link', Jekyll::GreyciteBiblio)