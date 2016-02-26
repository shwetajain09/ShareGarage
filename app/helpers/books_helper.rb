module BooksHelper

def not_shared?(book)
	book_user = book.books_users.find_by_user_id(current_user)
	book_user.is_provided == false
end

def get_location_class(book_id,location)
	book_user = current_user.books_users.find_by_book_id(book_id)
	if book_user.present?
		if book_user.locations.collect(&:id).include?(location)
			return 'active'			
		else
			return
		end
	end
end

def get_location_value(book_id,location)
	book = current_user.shared_books.find_by_id(book_id)
	if book.present?
		book_locations = current_user.shared_books.find_by_id(book_id).pick_locations.collect(&:id)
		if book_locations.include?(location)
			return true	
		else
			return false	
		end
	end
end

def get_contact_info(provider)
	if provider.show_phone
		provider.phone_no.presence
	end
end

def get_provided_status(book_id,user_id)
	bu = BooksUser.find_by_book_id_and_user_id(book_id,user_id)
	return bu.is_provided
end

end
