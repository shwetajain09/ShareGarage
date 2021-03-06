class UserMailer < ActionMailer::Base
  default :from => "team@sharegarage.com"

   def send_user_contacting_message(params)
    @user = params[:name]
    @phone = params[:phone]
    @email = params[:email]
    @message = params[:message]
    mail(:to => "team@sharegarage.com", :subject => "Some one is contacting us!")
  end

  def donate_request(params)
    @email = params[:email]
    mail(:to => "team@sharegarage.com", :subject => "Some one want to donate!")
  end

  def request_book(requester,book_title,options={})
  	@requester_email = requester.email
    @requester = requester
    if options[:provider].present?
    	@requestee = options[:provider].email
    	@requestee_name = options[:provider].full_name
    else
      @requestee = "team@sharegarage.com"
      @requestee_name = "Team"
    end
    @google_id = options[:google_id]
    @title = book_title
    mail(:to => @requestee, :subject => "Book Request")
  end

  def send_token_details(user,token)
    @user = user
    @token = token
    mail(:to => @user.email, :subject => "BookCoin details")
  end
end