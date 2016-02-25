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
		if transaction.available_unlocked
			response = {:redeem => 'Available',:class => 'alert-info',:message => 'Use this BookCoin to get a book of your choice'}
		elsif transaction.locked
			response = {:redeem => 'Locked',:class => 'alert-danger' ,:message => "You've locked this BookCoin to get book #{link_to transaction.book.title,book_path(transaction.book_id)} from the book owner #{link_to transaction.receiver.full_name,user_path(transaction.receiver)}",:show_unlock=>true}
		elsif transaction.redeemed
			response = {:redeem => 'Already redeemed',:class => 'alert-success',:message => "You've used this BookCoin and got #{link_to transaction.book.title,book_path(transaction.book_id)} from #{link_to transaction.receiver.full_name,user_path(transaction.receiver)}"}
		end
		return response
	end

end
