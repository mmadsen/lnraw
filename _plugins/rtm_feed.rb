require 'feedjira' # atom/rss API
require 'octokit'   # Github API
require 'nokogiri'  # Parse HTML

# Github feed based on feedzirra rather than the Github API

module Jekyll
  class RtmFeed < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      input = text.split(/, */ )
      @count = input[1]
      if input[1] == nil
        @count = 3
      end
    end
    def render(context)
      puts "Generating RTM feed from rss using feedzirra with rtm_feed.rb"
      feed = Feedjira::Feed.fetch_and_parse("http://www.rememberthemilk.com/atom/mark.e.madsen/21802795")
      # consider formatting properly
      if defined?(feed.entries)
        out = "<ul>"
        for i in 0 ... @count.to_i
          doc = Nokogiri::HTML.parse(feed.entries[i].content) # parse the content
          # Print title, content
          out = out + "<li>" +
            feed.entries[i].title + ": " +
            "<em>" +
            doc.css('blockquote').text.gsub(/\n/, ' ').squeeze(' ').strip[0 .. 150] +
            "</em>" +
            " <a href=\"" + feed.entries[i].url + "\">" +
            feed.entries[i].published.strftime("%I:%M %Y/%m/%d") + "</a>" +
            "</li>"
        end
        out + "</ul>"
      else
        " "
      end
    end
  end
end ## end module Jekyll

Liquid::Template.register_tag('rtm_feed', Jekyll::RtmFeed)




