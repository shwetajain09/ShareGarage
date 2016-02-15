class TransactionsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@my_token = current_user.tokens.unused.count
		@my_credit = current_user.profile.credit
		@transactions = (current_user.credit_token+current_user.debit_token).sort_by(&:created_at).reverse!.paginate :page =>  params[:page], :per_page => 10
	end
end
