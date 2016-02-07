class Location < ActiveRecord::Base
	has_and_belongs_to_many :books_users, :uniq => true, :read_only => true
	has_many :profiles
	has_many :children, :class_name => "Location",:foreign_key => :parent_id
  	belongs_to :parent, :class_name => "Location" 
	searchable do
		text :name
	end

end

