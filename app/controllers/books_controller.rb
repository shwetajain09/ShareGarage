class BooksController < ApplicationController
	require 'googlebooks'

	before_filter :authenticate_user!, :except => [:search,:library,:index,:show_share_modal,:show_providers,:vote]
	before_filter :load_book, :only => [:edit_shared,:delete_shared,:update_pick_location]

	def load_book
		@book  = Book.find(params[:id])
	end

	def index
		@popular_books = Book.available.tagged_with("Popular").last(6)
	end

	def search_with_tag
		@grab = true
		
		redirect_to library_books_path
	end

	def library
		@grab = true
		if params[:tag].present?
			@books = Book.available.tagged_with(params[:tag]).paginate :page =>  params[:page], :per_page => 9
			@query = params[:tag]
		else
			@search = Book.available.search do
				fulltext params[:location_query],:fields=>:pick_locations
			    fulltext params[:book_query]
			    paginate :page =>  params[:page], :per_page => 9
			  end
	  		@books = @search.results
	  		if @books.empty?
	  			@grab = false
	  			@books = GoogleBooks.search("#{params[:book_query]}", {:count => 30})
	  		end
	  		@query = params[:location_query] +"  " + params[:book_query] 
		end
		
  		
	end

	def search
		@books = GoogleBooks.search("#{params[:book_query]}", {:count => 30})
		@query = params[:book_query]
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
		#params[:location_ids].merge(current_user.profile.try(:location_id))
		book_user.locations.destroy_all
		loc = Location.include(&:parent).where('id in (?)',params[:location_ids]).uniq
		book_user.locations << loc
		book_user.locations << loc.collect(&:parent).uniq
		if book_user.save
			if current_user.got_reward?
				message = "Woooh! your book has been successfully uploaded. keep sharing."
			else
				message = "Woooh! you got 1 BookCoin on your first book upload. keep sharing."
			end
			redirect_to shelf_user_path(current_user),:notice => message
		else
			@errors = book_user.errors.full_messages.join(',')
			redirect_to :back,:notice => "#{@errors}"
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
		begin
			@book = Book.find(params[:id])
			@comments = Comment.where(:commentable_id => @book.id,:commentable_type => 'book').paginate :page =>  params[:page], :per_page => 10
			@likes = @book.get_likes.size
		rescue
			@book = GoogleBooks.search("id:#{params[:id]}").first
			
		end

		
	end

	def show_providers
		@book  = Book.find(params[:id])
		@providers = @book.providers#.where.not(id: current_user.id)
	end

	def vote
		@book  = Book.find(params[:id])
		if params[:vote] == "true"
			@book.liked_by current_user
		else
			@book.unliked_by current_user
		end		
		@likes = @book.get_likes.size
	end




	private
	def add_author(book,author)
		author = Author.find_or_initialize_by(:name => author)
		author.save!
		book.authors << author
	end

	def add_book_provider(book)
		book_user = current_user.books_users.find_or_initialize_by(:book_id => book.id)
		book_user.is_provided = true
		update_pick_location(book_user)
	end

	def add_book_and_provider(book)
		@book = Book.new(:google_id => book.id)
		@book.attributes = {:title => book.title,:google_provided_rating => book.average_rating,:description => book.description,:subtitle => book.title,:link=> book.info_link,:publisher => book.publisher,:published_date => book.published_date,:page_count => book.page_count,:count => 1,:json_details=>book.to_json,:isbn => book.isbn.presence || book.other_identifier}
		language = Language.find_or_initialize_by(:locale => book.language)
		language.save!
		@book.language = language
		image_url = book.image_link(:zoom => 2)
		@book.avatar = URI.parse(image_url)
		
		if book.authors.kind_of?(Array)
			book.authors.each do |author|
				add_author(@book,author)
			end
		else
			add_author(@book,book.authors)
		end

		if book.authors.kind_of?(Array)
			book.authors.each do |tag|
				@book.tag_list.add(tag)
			end
		else
			@book.tag_list.add(book.categories)
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
    def book_params
	    params.require(:book).permit(:tag_list) 
	end
end
