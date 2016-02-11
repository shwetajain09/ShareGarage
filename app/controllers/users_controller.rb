class UsersController < ApplicationController
before_filter :authenticate_user!,:load

def load
	@locations = Location.all
	@user = current_user
end


def update
	debugger
	if @user.update_attributes(user_params)
	else
		render 'edit'
	end
end

def shelf
	@books = current_user.books.paginate :page =>  params[:page], :per_page => 3
end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:create) { |u| u.permit(:avatar) }
        # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth, :avatar) }
    end

	
end
