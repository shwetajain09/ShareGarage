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
		redeemer.profile.credit += self.credit
		redeemer.profile.save
		redeemer.credit_transactions.create(:giver_id => self.owner,:message => AppConfiguration::TOKEN_REDEMPTION,:credit => self.credit,:token_id=>self.id)
		self.is_redeemed = true
		self.save
		if self.giver.present?
			self.giver.profile.credit -= self.credit
			self.giver.profile.save
			self.giver.debit_transactions.create(:receiver_id => redeemer.id,:message => AppConfiguration::TOKEN_REDEMPTION,:credit => self.credit,:token_id=>self.id)
		end
	end

	def check_validity
		return !self.is_redeemed && self.valid_til >= Date.today
	end

end
