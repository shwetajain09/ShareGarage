class HomeController < ApplicationController

  def show_modal
  end

  def submit_form
  	UserMailer.send_user_contacting_message(params).deliver
  	render json: nil, status: :ok	  
  end
  
end
