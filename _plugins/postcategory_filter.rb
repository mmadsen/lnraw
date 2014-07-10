require 'facets/string/titlecase'

module Jekyll
	module PostAndCategoryFilter

		def get_github_for_model(model)
			urls = {'model:seriationct' => 'https://github.com/mmadsen/seriationct',
					'model:ctmixtures' => 'https://github.com/mmadsen/ctmixtures',
					'model:axelrod-ct' => 'https://github.com/mmadsen/axelrod-ct',
					'model:ctpy' => 'https://github.com/mmadsen/ctpy'}
			url = urls[model]
			url
		end


		def get_project_url(project)
			urls = { 'project:coarse grained model' => '/projects/coarsegraining',
				     'project:structured information' => '/projects/structuredinfo',
				     'project:niche construction' => '/projects/nicheconstruction'}
			url = urls[project]
			url
		end


		def posts_without_essays(posts)
			filtered = []
			for post in posts
				filtered.push(post) unless post.categories.include? "essays"
			end
			filtered
		end

		def categories_with_prefix(categories, prefix)
			filtered = []
			for cat in categories.keys
				filtered.push(cat) if cat.include? prefix
			end
			filtered.sort
		end

		def get_project_category(categories)
			project = ""
			categories.each { |x| project = strip_prefix_and_titleize_category(x) if x.include? "project:"} 
			project
		end	

		def get_raw_project_category(categories)
			project = ""
			categories.each { |x| project = x if x.include? "project:"}
			project
		end

		def strip_prefix_and_titleize_category(fullcategory)
			prefix, sep, cat_name = fullcategory.rpartition(":")
			cat_name.titlecase
		end
	end
end

Liquid::Template.register_filter(Jekyll::PostAndCategoryFilter)
