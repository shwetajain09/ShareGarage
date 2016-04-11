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
	  has_many :comments, as: :commentable 
	  
	extend FriendlyId
  	friendly_id :title, use: [:slugged, :finders]
  	  acts_as_commentable
  	  acts_as_votable
	#has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	has_attached_file :avatar, :styles => {medium: "300x300>", thumb: "100x100>"},
:path => "/shared_assets/photos/books/:id/:style/:basename.:extension",
:url => "/shared_assets/photos/books/:id/:style/:basename.:extension",
:storage => :s3,
:s3_credentials => "#{Rails.root.to_path}/config/aws.yml"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	validates_presence_of :google_id
	validates_uniqueness_of :google_id

	after_save :load_into_soulmate
	before_destroy :remove_from_soulmate

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
	def is_available
		self.books_users.where(:is_provided => true).present?
	end

	

	private 

	def load_into_soulmate
		loader = Soulmate::Loader.new("books")
		loader.add("term" => title, "id" => self.id)
	   	
	end

	def remove_from_soulmate
		loader = Soulmate::Loader.new("books")
	    loader.remove("id" => self.id)
	end
end






  # def s3_credentials
  #   {:bucket => "sg-staging-assets", :access_key_id => "AKIAIOESJ4BRQ2AXULWA", :secret_access_key => "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",:s3_host_name => 's3-us-west-2.amazonaws.com'}
  # end