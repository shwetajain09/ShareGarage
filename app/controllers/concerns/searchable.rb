# module Searchable
#   extend ActiveSupport::Concern
#   	attr_accessible :get_books
#   	attr_reader :search_query

# 	def get_books(search_query)
# 		@search = Book.available.search do
# 		    fulltext @search_query		   
# 		  end
#   		@books = @search.results
# 	end
# end