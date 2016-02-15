class TransactionsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@my_token = current_user.tokens.unused.count
		@unused = current_user.tokens.unlocked_unused.order('id desc')
		@used = current_user.tokens.used.order('id desc')
		@locked = current_user.tokens.locked.order('id desc')
		#@transactions = (current_user.credit_token+current_user.debit_token).sort_by(&:created_at).reverse!.paginate :page =>  params[:page], :per_page => 10
	end
end
