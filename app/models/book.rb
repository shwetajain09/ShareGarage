class Book < ActiveRecord::Base	
	belongs_to :language
	has_and_belongs_to_many :authors, :uniq => true, :read_only => true
	has_many :books_users,dependent: :destroy
	has_many :providers, ->{where "books_users.is_provided = true"}, through: :books_users, source: :user,dependent: :destroy
	has_many :readers, ->{where "books_users.is_provided = false"}, through: :books_users, source: :user,dependent: :destroy
	scope :available, ->{Book.joins(:providers)}
	has_many :pick_locations, ->{where "books_users.is_provided = true"}, through: :books_users, source: :locations,dependent: :destroy
	has_many :transactions
	has_many :book_requests
	extend FriendlyId
  	friendly_id :title, use: [:slugged, :finders]

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	validates_presence_of :google_id
	validates_uniqueness_of :google_id
	def slug_candidates
      [
        :title
       
      ]
    end
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
