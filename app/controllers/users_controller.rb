class UsersController < ApplicationController
before_filter :authenticate_user!, :except => :request_book
before_filter :load

def load
	@locations = Location.all
	@user = current_user
end


def update
	if @user.update_attributes(user_params)
	else
		render 'edit'
	end
end

def shelf
	@books = current_user.books.order('id DESC').paginate :page =>  params[:page], :per_page => 9
end

def request_book	
	if current_user.present?
		if params[:book_id].present? && params[:user_id].present?
			@requestee = User.find(params[:user_id])
			@book  = Book.find(params[:book_id])
			@title = @book.title
			options = {:provider => @requestee,:google_id => @google_id}
			@requested_to_user = true
		else
			@requested_to_user = false
			@book = Book.find_by_google_id(params[:google_id])
			if @book.present?
				add_book_request(@book)
			else
				book = GoogleBooks.search("id:#{params[:google_id]}").first
				add_book_and_request(book)
			end					
			options = {:google_id => @google_id}		
			
		end
		UserMailer.request_book(current_user,@title,options).deliver

	end
end

def show
	@user = User.find(params[:id])
end
def show_requested_books
	user = User.find_by_id(params[:format])
	if user.present?
		@books = current_user.book_requests.collect(&:book).uniq.sort_by(&:created_at).reverse!.paginate :page =>  params[:page], :per_page => 9
	else
		@books = BookRequest.all.collect(&:book).uniq.sort_by(&:created_at).reverse!.paginate :page =>  params[:page], :per_page => 9
	end
end

def add_book_and_request(book)
	@book = Book.new(:google_id => book.id)
	@book.attributes = {:title => book.title,:description => book.description,:google_provided_rating => book.average_rating,:subtitle => book.title,:link=> book.info_link,:publisher => book.publisher,:published_date => book.published_date,:page_count => book.page_count,:count => 1,:json_details=>book.to_json,:isbn => book.isbn.presence || book.other_identifier}
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
		add_book_request(@book)
	else
		redirect_to :back, :notice => "Oops! something went wrong! we were not able to request your book. You can write to us team@sharegarage.com"
	end
end
	private
	def add_author(book,author)
		author = Author.find_or_initialize_by(:name => author)
		author.save!
		book.authors << author
	end
	def add_book_request(book)
		current_user.book_requests.create(:book_id => book.id)
		@title = book.title
		@google_id = book.google_id
	end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:create) { |u| u.permit(:avatar,:slug) }
        # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth, :avatar) }
    end

	
end
