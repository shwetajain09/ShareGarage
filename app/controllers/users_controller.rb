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
	@books = current_user.books
end

private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

	
end
