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
	@books = current_user.books.paginate :page =>  params[:page], :per_page => 3
end

def request_book	
	if current_user.present?
		if params[:book_id].present? && params[:user_id].present?
			@requestee = User.find_by_id(params[:user_id])
			@book  = Book.find_by_id(params[:book_id])
			title = @book.title
			options = {:provider => @requestee}
		else
			title = params[:book_title]
			options = {:google_id => params[:google_id]}
		end
		UserMailer.request_book(current_user,title,options).deliver
	end
end
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:create) { |u| u.permit(:avatar,:slug) }
        # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth, :avatar) }
    end

	
end
