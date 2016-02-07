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
			return 'fa-plus-circle'
		elsif transaction.is_debit?(current_user)
			return 'fa-minus-circle'
		end
	end

end
