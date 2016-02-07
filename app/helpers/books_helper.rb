module BooksHelper

def not_shared?(book)
	book_user = book.books_users.find_by_user_id(current_user)
	book_user.is_provided == false
end

def get_location_class(book_id,location)
	book = current_user.shared_books.find_by_id(book_id)
	if book.present?
		book_locations = current_user.shared_books.find_by_id(book_id).pick_locations.collect(&:id)
		if book_locations.include?(location)
			return 'active'			
		end
	end
end

end
