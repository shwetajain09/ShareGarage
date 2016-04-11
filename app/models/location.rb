class Location < ActiveRecord::Base
	has_and_belongs_to_many :books_users, :uniq => true, :read_only => true
	has_many :profiles
	has_many :children, :class_name => "Location",:foreign_key => :parent_id
  	belongs_to :parent, :class_name => "Location" 
	searchable do
		text :name
	end

	after_save :load_into_soulmate
	before_destroy :remove_from_soulmate

	private 

	def load_into_soulmate
		loader = Soulmate::Loader.new("locations")
		loader.add("term" => name, "id" => self.id)
	   	
	end

	def remove_from_soulmate
		loader = Soulmate::Loader.new("locations")
	    loader.remove("id" => self.id)
	end

end

