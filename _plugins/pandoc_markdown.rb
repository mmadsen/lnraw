module Jekyll
	class Jekyll::Converters::Markdown::Pandoc
 	def initialize(config)
 		require 'pandoc-ruby'
 		@config = config
 		rescue LoadError
 		STDERR.puts 'You are missing an library required for Markdown. Please run:'
 		STDERR.puts '  $ [sudo] gem install pandoc-ruby'
 		raise FatalException.new("Missing dependency: pandoc-ruby")
 	end
 	
 	def convert(content)
 		extensions = config_option('extensions', [])
 		format = config_option('format', 'html5')
 	
		::PandocRuby.new(content, *extensions).send("to_#{format}")
 	end
 	def config_option(key, default=nil)
 		case @config['pandoc']
 			when nil then default
 			else @config['pandoc'].fetch(key, default)
 		end
    end
 end
end
