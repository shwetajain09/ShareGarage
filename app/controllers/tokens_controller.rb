class TokensController < ApplicationController
	before_filter :authenticate_user!
	def new
	end
	# def create
	# 	@temp_credit = current_user.profile.credit
	# 	if @temp_credit >= AppConfiguration::TOKEN_GENERATION_CREDIT
	# 		raw_string = SecureRandom.random_number( 2**80 ).to_s( 20 ).reverse
	# 	    long_code = raw_string.tr( '0123456789abcdefghij', '234679QWERTYUPADFGHX' )
	# 	    short_code = long_code[0..3] + '-' + long_code[4..7] + '-' + long_code[8..11]
	# 	    token = current_user.tokens.new(:redeem_code => short_code,:owner => current_user,:credit => AppConfiguration::TOKEN_GENERATION_CREDIT,:receiver_id => params[:receiver_id],:book_id => params[:book_id])
	# 	    if token.save
	# 	      current_user.profile.credit -= AppConfiguration::TOKEN_GENERATION_CREDIT
	# 	      current_user.debit_transactions.create(:message => AppConfiguration::GENERATED_TOKEN,:credit => AppConfiguration::TOKEN_GENERATION_CREDIT,:token_id => token.id,:receiver_id => params[:receiver_id],:book_id => params[:book_id])
	# 	      current_user.profile.save
	# 	      message = "Successfully generated token"
	# 	    else
	# 		   message = "Errors:#{token.errors.full_messages.join(',')}"
	# 		end
	# 	else
	# 		message = "Not enough credits to generate token"
	# 	end
	# 	redirect_to user_transactions_path(current_user),:notice => message
	# end

	def update
		@token = Token.find_by_id(params[:id])
		code = @token.generate_token
		@token.update_attributes(:redeem_code=> code,:receiver_id => params[:user_id],:book_id => params[:book_id],:valid_til => Date.today+7.days)
		@book = Book.find_by_id(@token.book_id)
		UserMailer.send_token_details(current_user,@token).deliver
	end

	def redeem_token
		@token = Token.find_by_redeem_code(params[:token])
		if @token.present? && @token.check_validity(:receiver_id => current_user.id)
			@token.redeem_token(current_user)
			message = "Redeemed Successfully"
		else
			message = "Invalid token!"
		end
		redirect_to user_transactions_path(current_user),:notice => message
	end	

	def unlock_book_coin
		@token = Token.find_by_id(params[:id])
		user = User.find(params[:user_id]) 
		if @token.present? && user.present? && @token.check_unlock_validity(user.id)
			@token.unlock_token(current_user)
			message = "Unlocked Successfully"
		else
			message = "Invalid token!"
		end
		redirect_to user_transactions_path(current_user),:notice => message
	end

end
