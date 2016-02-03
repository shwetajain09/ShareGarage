class BooksUser < ActiveRecord::Base
	belongs_to :book, touch: true
	belongs_to :user
	has_and_belongs_to_many :locations, -> { uniq }
	validates_uniqueness_of :user_id, scope: :book_id
	validates_presence_of :locations, :if => :is_provided?

	before_create :add_credit

	UPLOAD_CREDIT=2
	TOKEN_GENERATION_CREDIT = 10
	TEAM = 'team'
	TEAM_ID= 1
	UPLOAD_BOOK = 'Uploaded a book'
	GENERATED_TOKEN = 'Generated a token'

	def add_credit
		self.user.profile.credit += UPLOAD_CREDIT
		@temp_credit = self.user.profile.credit
		self.user.credit_transactions.create(:giver_id => TEAM_ID,:message => UPLOAD_BOOK,:book_id => self.book.id,:credit => UPLOAD_CREDIT)
		if validate_token_generation
			generate_token
		end
		
	end

	def validate_token_generation
		@temp_credit >= TOKEN_GENERATION_CREDIT
	end

	def generate_token
		raw_string = SecureRandom.random_number( 2**80 ).to_s( 20 ).reverse
		long_code = raw_string.tr( '0123456789abcdefghij', '234679QWERTYUPADFGHX' )
		short_code = long_code[0..3] + '-' + long_code[4..7] + '-' + long_code[8..11]
		token = self.user.tokens.new(:redeem_code => short_code,:provider => TEAM)
		if token.save
			self.user.profile.credit -= TOKEN_GENERATION_CREDIT
			self.user.debit_transactions.create(:receiver_id => TEAM_ID,:message => GENERATED_TOKEN,:book_id => self.book.id,:credit => TOKEN_GENERATION_CREDIT)
		end
	end

end
