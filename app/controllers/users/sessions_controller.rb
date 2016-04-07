class Users::SessionsController < Devise::SessionsController

  def google_oauth2
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.user_attributes"] = @user.attributes
        redirect_to new_user_registration_url
      end
  end

  def failure
    flash[:notice] = params[:message]
    redirect_to root_path
  end

end
