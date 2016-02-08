class Token < ActiveRecord::Base
	belongs_to :user,:class_name => 'User',:foreign_key => :owner, :counter_cache => true
	has_one :debit_transaction,:class_name => 'Transaction',:foreign_key => :transaction_id


	def redeem_token(redeemer)		
		redeemer.profile.credit += self.credit
		redeemer.profile.save
		redeemer.credit_transactions.create(:giver_id => self.owner,:message => AppConfiguration::TOKEN_REDEMPTION,:credit => self.credit,:token_id=>self.id)
		self.is_redeemed = true
		self.save
		if self.user.present?
			self.user.profile.credit -= self.credit
			self.user.profile.save
			self.user.debit_transactions.create(:receiver_id => redeemer.id,:message => AppConfiguration::TOKEN_REDEMPTION,:credit => self.credit,:token_id=>self.id)
		end
	end


end
