class Location < ActiveRecord::Base
	has_and_belongs_to_many :books_users, :uniq => true, :read_only => true
	has_many :profiles
	searchable do
		text :name
	end

end

