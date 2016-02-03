class Book < ActiveRecord::Base	
	belongs_to :language
	has_and_belongs_to_many :authors, :uniq => true, :read_only => true
	has_many :books_users
	has_many :providers, ->{where "books_users.is_provided = true"}, through: :books_users, source: :user
	has_many :readers, ->{where "books_users.is_provided = false"}, through: :books_users, source: :user
	scope :available, ->{Book.joins(:providers)}
	has_many :pick_locations, ->{where "books_users.is_provided = true"}, through: :books_users, source: :locations
	has_many :transactions
	
	after_touch :index
	acts_as_taggable
	searchable do 	
		text :title
		text :authors do 
			authors.map { |e| e.name  }
		end
		text :pick_locations do 
			pick_locations.map { |e| e.name }
		end
		text :isbn
	end


end
