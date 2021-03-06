class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable,  :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :first_name, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,:lockable,
         :recoverable, :rememberable, :trackable, :validatable#,:confirmable
  acts_as_voter
  attr_accessor :reward_not_received
	has_many :books_users
	has_many :books ,through: :books_users, source: :book
	has_many :shared_books, ->{where "books_users.is_provided = true"}, through: :books_users, source: :book
	has_many :reading_books, ->{where "books_users.is_provided = false"}, through: :books_users, source: :book
  has_many :tokens,:foreign_key => :owner
  scope :token_count, ->{where "tokens.is_redeemed is false"}
  has_many :credit_transactions, :class_name => 'Transaction',:foreign_key => :receiver_id
  has_many :debit_transactions, :class_name => 'Transaction',:foreign_key => :giver_id
  has_many :credit_token, :class_name => 'Token',:foreign_key => :receiver_id
  has_many :debit_token, :class_name => 'Token',:foreign_key => :owner
  has_one :profile
  has_many :book_requests
  validates_presence_of :gender
  validates_presence_of :phone_no, :if => :show_phone?
  after_create :generate_profile

  def slug_candidates
      [
        :first_name,:last_name
       
      ]
    end

  def set_picture_respect_to_gender
    self.gender == 'F' ? '/assets/girl.jpeg' : '/assets/boy.jpeg'
  end

  #has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :avatar, :styles => {medium: "300x300>", thumb: "100x100>"}, :default_style => :thumb, :default_url => :set_picture_respect_to_gender,
  :path => "/shared_assets/photos/users/:id/:style/:basename.:extension",
  :url => "/shared_assets/photos/users/:id/:style/:basename.:extension",
  :storage => :s3,
  :s3_credentials => "#{Rails.root.to_path}/config/aws.yml"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
    
  def generate_profile
    loc = Location.find_by_name(AppConfiguration::DEFAULT_LOCATION)
    self.create_profile(:location_id => loc.id,:rating => AppConfiguration::DEFAULT_RATING)
    #Token.generate_book_coin(self)
  end

  


  def after_confirmation
    super
    #add_credit
  end

  # def add_credit
  #   self.profile.credit += AppConfiguration::SIGN_UP_CREDIT
  #   self.profile.save
  #   self.credit_transactions.create(:giver_id => TEAM_ID,:message => AppConfiguration::SIGN_UP_CREDIT_MESSAGE,:credit => AppConfiguration::SIGN_UP_CREDIT)
  # end

  def full_name   
    (first_name.capitalize.to_s+" "+last_name.capitalize.to_s).presence || email
  end 


end
