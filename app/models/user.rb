class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable,  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,:lockable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	has_many :books_users
	has_many :books ,through: :books_users, source: :book
	has_many :shared_books, ->{where "books_users.is_provided = true"}, through: :books_users, source: :book
	has_many :reading_books, ->{where "books_users.is_provided = false"}, through: :books_users, source: :book
  has_many :tokens,:foreign_key => :owner
  has_many :credit_transactions, :class_name => 'Transaction',:foreign_key => :receiver_id
  has_many :debit_transactions, :class_name => 'Transaction',:foreign_key => :giver_id
  has_one :profile

  after_create :generate_profile


    
  def generate_profile
    self.create_profile(:location_id => 2)
  end

  def after_confirmation
    super
    add_credit
  end

  def add_credit
    self.profile.credit += AppConfiguration::SIGN_UP_CREDIT
    self.profile.save
    self.credit_transactions.create(:giver_id => TEAM_ID,:message => AppConfiguration::SIGN_UP_CREDIT_MESSAGE,:credit => AppConfiguration::SIGN_UP_CREDIT)
  end

  def full_name   
    (first_name.to_s+last_name.to_s).presence || email
  end


end
