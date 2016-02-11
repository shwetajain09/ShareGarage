class UserMailer < ActionMailer::Base
  default :from => "team@sharegarage.com"

   def send_user_contacting_message(params)
    @user = params[:name]
    @phone = params[:phone]
    @email = params[:email]
    @message = params[:message]
    mail(:to => "team@sharegarage.com", :subject => "Some one is contacting us!")
  end
end