class Users::RegistrationsController < Devise::RegistrationsController
protected
	def after_update_path_for(resource)
      user_path(resource)
    end
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
   def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,:gender,:phone_no,:show_phone)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation,:avatar,:phone_no,:gender,:phone_no,:show_phone)
  end
end
