class Transaction < ActiveRecord::Base
	belongs_to :token
	belongs_to :receiver, :class_name => 'User', :foreign_key => :receiver_id 
	belongs_to :giver, :class_name => 'User', :foreign_key => :giver_id
	belongs_to :book

	def transaction_state(user)
		if receiver == user
			return 'credit'
		elsif giver == user
			return 'debit'
		end
	end

	def is_credit?(user)
		receiver == user
	end

	def is_debit?(user)
		giver == user
	end

end
