class Token < ActiveRecord::Base
	belongs_to :giver,:class_name => 'User',:foreign_key => :owner, :counter_cache => true
	has_one :debit_transaction,:class_name => 'Transaction',:foreign_key => :transaction_id
	belongs_to :receiver, :class_name => 'User', :foreign_key => :receiver_id
	belongs_to :book, :class_name => 'Book', :foreign_key => :book_id
	scope :unused, ->{where "is_redeemed is false"}
	scope :used, ->{where "is_redeemed is true"}
	scope :locked, ->{where "is_redeemed is false and receiver_id is not null and book_id is not null"}
	scope :unlocked_unused, -> {where "is_redeemed is false and receiver_id is null and book_id is null"}


	def redeem_token(redeemer)		
		# redeemer.profile.credit += self.credit
		# redeemer.profile.save
		# redeemer.credit_transactions.create(:giver_id => self.owner,:message => AppConfiguration::TOKEN_REDEMPTION,:credit => self.credit,:token_id=>self.id)
		self.is_redeemed = true
		self.save
		Token.generate_book_coin(redeemer)
		if self.receiver_id.present? && self.book_id.present? && owner.present?
			book_user = BooksUser.find_by_book_id_and_user_id(self.book_id,self.receiver_id)
			book_user.locations.destroy_all
			new_book_user = BooksUser.find_by_book_id_and_user_id(self.book_id,owner)
			if new_book_user.present?
				new_book_user.count += 1
			else
				new_book_user = BooksUser.create(:book_id => self.book_id,:user_id => owner,:is_provided => false)
			end
			book_user.destroy
			# self.giver.profile.credit -= self.credit
			# self.giver.profile.save
			# self.giver.debit_transactions.create(:receiver_id => redeemer.id,:message => AppConfiguration::TOKEN_REDEMPTION,:credit => self.credit,:token_id=>self.id)
		end
	end

	def check_validity(options = {})
		if options[:receiver_id].present?
			return self.receiver_id == options[:receiver_id] && !self.is_redeemed 
		else
			return !self.is_redeemed
		end
		
	end

	def check_unlock_validity(user_id)
		return (self.owner == user_id) && !self.is_redeemed
	end

	def unlock_token(user)
		self.destroy
		token = user.tokens.new(:credit => AppConfiguration::TOKEN_GENERATION_CREDIT)
	    token.save
	end

	def self.generate_book_coin(user)
		token = user.tokens.new(:credit => AppConfiguration::TOKEN_GENERATION_CREDIT)
	    token.save
	end

	def generate_token
	    raw_string = SecureRandom.random_number( 2**80 ).to_s( 20 ).reverse
	    long_code = raw_string.tr( '0123456789abcdefghij', '234679QWERTYUPADFGHX' )
	    short_code = long_code[0..3] + '-' + long_code[4..7] + '-' + long_code[8..11]
	    return short_code
	end

	def available_unlocked
		!self.is_redeemed? && !self.book_id.present? && !self.receiver_id.present?
	end
	def locked
		!self.is_redeemed? && self.book_id.present? && self.receiver_id.present?
	end
	def redeemed
		self.is_redeemed?
	end
end
