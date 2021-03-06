class BooksUser < ActiveRecord::Base
	belongs_to :book, touch: true
	belongs_to :user
	has_and_belongs_to_many :locations, -> { uniq }
	validates_uniqueness_of :user_id, scope: :book_id
	validates_presence_of :locations, :if => :is_provided?

	after_create :add_book_coin, :if => :adding_first_time	
	after_create :add_history

	def adding_first_time
		!self.user.got_reward?
	end

	def add_history
		if self.user.profile.location.present?
			location = self.user.profile.location.name
			BookUserHistory.create(:user_id => self.user_id,:book_id => self.user_id,:location => location)
		end	
	end


	def add_book_coin
		Token.generate_book_coin(self.user)
		self.user.update_attributes(:got_reward => true)
		self.user.reward_not_received = true
	end

	def add_credit
		# self.user.profile.credit += AppConfiguration::UPLOAD_CREDIT
		# @temp_credit = self.user.profile.credit
		# if validate_token_generation
		# 	generate_token
		# end	
		# self.user.profile.save	
		# self.user.credit_transactions.new(:giver_id => AppConfiguration::TEAM_ID,:message => AppConfiguration::UPLOAD_BOOK,:book_id => self.book.id,:credit => AppConfiguration::UPLOAD_CREDIT)
		# @debit_tran.save if @debit_tran.present?
	end

	def validate_token_generation
		@temp_credit >= AppConfiguration::TOKEN_GENERATION_CREDIT
	end

	# def generate_token
	# 	raw_string = SecureRandom.random_number( 2**80 ).to_s( 20 ).reverse
	# 	long_code = raw_string.tr( '0123456789abcdefghij', '234679QWERTYUPADFGHX' )
	# 	short_code = long_code[0..3] + '-' + long_code[4..7] + '-' + long_code[8..11]
	# 	token = self.user.tokens.new(:redeem_code => short_code,:owner => self.user_id,:credit => AppConfiguration::TOKEN_GENERATION_CREDIT)
	# 	if token.save
	# 		self.user.profile.credit -= AppConfiguration::TOKEN_GENERATION_CREDIT
	# 		@debit_tran = self.user.debit_transactions.new(:message => AppConfiguration::GENERATED_TOKEN,:credit => AppConfiguration::TOKEN_GENERATION_CREDIT,:token_id=>token.id)
	# 	end
	# end

	def deduct_credit
		# self.user.profile.credit -= AppConfiguration::UNSHARE_CREDIT
		# self.user.profile.save
		# self.user.debit_transactions.create(:message => AppConfiguration::UNSHARED_BOOK,:book_id => self.book.id,:credit => AppConfiguration::UNSHARE_CREDIT)
	end

end
