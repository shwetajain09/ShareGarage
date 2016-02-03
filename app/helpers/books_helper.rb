module BooksHelper

def not_shared?(book)
	book_user = book.books_users.find_by_user_id(current_user)
	book_user.is_provided == false
end

end
