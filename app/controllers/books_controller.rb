class BooksController < ApplicationController
	require 'googlebooks'

	before_filter :authenticate_user!, :except => [:search,:library,:index]
	before_filter :load_book, :only => [:edit_shared,:delete_shared,:show_providers,:update_pick_location]

	def load_book
		@book  = Book.find(params[:id])
	end

	def index
		@books = Book.available
		render :layout => false
	end

	def library
		@search = Book.available.search do
			fulltext params[:location_query],:fields=>:pick_locations
		    fulltext params[:book_query]
		  end
  		@books = @search.results
	end

	def search
		# @search = Book.available.search do
		#     fulltext params[:book_query]
		#   end
  # 		@books = @search.results
  # 		if @books.empty?
			@books = GoogleBooks.search("#{params[:book_query]}")
		#end
	end

	def share
		@book = Book.find_by_google_id(params[:google_id])
		if @book.present?
			add_book_provider(@book)
		else
			book = GoogleBooks.search("id:#{params[:google_id]}").first
			add_book_and_provider(book)
		end		
	end


	def update_pick_location(book_user)
		#params[:location_ids].merge(current_user.location.id)
		book_user.locations << Location.where('id in (?)',params[:location_ids])
		book_user.is_provided = true
		if book_user.save
			redirect_to shelf_user_path(current_user),:success => "Shared the book"
		else
			redirect_to :back,:notice => "Already shared this book"
		end
	end
	
	def delete_shared
		book_user = current_user.books_users.find_by_book_id(@book.id)
		book_user.is_provided = false
		book_user.locations.destroy_all
		if book_user.save
			book_user.deduct_credit
			flash[:notice] = "Removed from sharing"
		else
			flash[:error] = "Not removed from shared bucket"
		end
		redirect_to :back
	end

	def show
		@book = Book.find_by_id(params[:id])
	end

	def show_providers
		@providers = @book.providers
	end


	def book_params
	    params.require(:book).permit(:tag_list) 
	end

	private
	def add_author(book,author)
		author = Author.find_or_initialize_by(:name => author)
		author.save!
		book.authors << author
	end

	def add_book_provider(book)
		book_user = current_user.books_users.find_or_initialize_by(:book_id => book.id)
		update_pick_location(book_user)
	end

	def add_book_and_provider(book)
		@book = Book.new(:google_id => book.id)
		@book.attributes = {:title => book.title,:subtitle => book.title,:link=> book.info_link,:publisher => book.publisher,:published_date => book.published_date,:page_count => book.page_count,:count => 1,:json_details=>book.to_json,:isbn => book.isbn.presence || book.other_identifier}
		language = Language.find_or_initialize_by(:locale => book.language)
		language.save!
		@book.language = language
		image_url = book.image_link(:zoom => 2, :curl => true)
		@book.avatar = URI.parse(image_url)
		if book.authors.kind_of?(Array)
			book.authors.each do |author|
				add_author(@book,author)
			end
		else
			add_author(@book,book.authors)
		end

		if @book.save
			add_book_provider(@book)
		else
			puts "#{@book.errors.full_messages.join(',')}"
			redirect_to :back, :notice => "#{@book.errors.full_messages.join(',')}"
		end
	end


    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:create) { |u| u.permit(:avatar) }
        # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth, :avatar) }
    end
end
