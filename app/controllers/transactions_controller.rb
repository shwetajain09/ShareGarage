class TransactionsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@my_token = current_user.tokens_count
		@my_credit = current_user.profile.credit
		@transactions = (current_user.credit_transactions+current_user.debit_transactions).sort_by(&:created_at)
	end
end
