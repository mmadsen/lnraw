require 'facets/string/titlecase'

module Jekyll
	module PostAndCategoryFilter
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


		def strip_prefix_and_titleize_category(fullcategory)
			prefix, sep, cat_name = fullcategory.rpartition(":")
			cat_name.titlecase
		end
	end
end

Liquid::Template.register_filter(Jekyll::PostAndCategoryFilter)
