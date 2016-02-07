class TokensController < ApplicationController
	before_filter :authenticate_user!
	def new
	end
	def create
		@temp_credit = current_user.profile.credit
		if @temp_credit >= AppConfiguration::TOKEN_GENERATION_CREDIT
			raw_string = SecureRandom.random_number( 2**80 ).to_s( 20 ).reverse
		    long_code = raw_string.tr( '0123456789abcdefghij', '234679QWERTYUPADFGHX' )
		    short_code = long_code[0..3] + '-' + long_code[4..7] + '-' + long_code[8..11]
		    token = current_user.tokens.new(:redeem_code => short_code,:owner => current_user,:credit => AppConfiguration::TOKEN_GENERATION_CREDIT)
		    if token.save
		      current_user.profile.credit -= AppConfiguration::TOKEN_GENERATION_CREDIT
		      current_user.debit_transactions.create(:message => AppConfiguration::GENERATED_TOKEN,:credit => AppConfiguration::TOKEN_GENERATION_CREDIT,:token_id => token.id)
		      current_user.profile.save
		      message = "Successfully generated token"
		    else
			   message = "Errors:#{token.errors.full_messages.join(',')}"
			end
		else
			message = "Not enough credits to generate token"
		end
		redirect_to user_transactions_path(current_user),:notice => message
	end

	def redeem_token
		@token = Token.find_by_redeem_code(params[:token])
		if @token.is_redeemed == false
			@token.redeem_token(current_user)
			message = "Redeemed Successfully"
		else
			message = "Already redeemed"
		end
		redirect_to user_transactions_path(current_user),:notice => message
	end	
end
