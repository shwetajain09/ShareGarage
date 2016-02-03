class TransactionsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@transactions = current_user.credit_transactions+current_user.debit_transactions
	end
end
