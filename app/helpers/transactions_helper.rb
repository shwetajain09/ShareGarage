module TransactionsHelper
	def get_message(message,options= {})
		if options[:redeem_code].present?
			message = message + " : "+options[:redeem_code] + " provided by " + options[:giver]
		elsif options[:book].present?
			message = message + " : "+options[:book]
		end
		return message
	end

	def get_class(transaction)
		if transaction.is_credit?(current_user)
			return 
		elsif transaction.is_debit?(current_user)
			return 
		end
	end

	def get_user_specific_details(transaction)
		if transaction.receiver == current_user
			response = {:user => transaction.giver, :action => '',:class => 'fa-plus-circle'}
		else
			response =  {:user => transaction.receiver,:action => '',:class => 'fa-minus-circle'}
		end
		if transaction.is_redeemed?
			response[:redeem] = 'Already redeemed'
		else
			response[:redeem] = 'Available'
		end
		return response
	end

end
