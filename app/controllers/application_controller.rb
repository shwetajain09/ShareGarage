class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :load

  def load
  	@locations = Location.all.order('name ASC')
  end

def after_sign_in_path_for(resource)
    # sign_in_url = new_user_session_url
    # if request.referer == sign_in_url
    #   super
    # else
    #   stored_location_for(resource) || request.referer || root_path
    # end
    root_url
  end

# def comment 
#   # Extracts the name of the class
#   klass = self.class.to_s[/\A(\w+)sController\Z/,1] 
#   # Evaluates the class and gets the current object of that class
#   @comentable_class = eval "#{klass}.find(params[:id])"
#   # Creates a comment using the data of the form
#   comment = Comment.new(params[:comment])
#   # Adds the comment to that instance of the class
#   @comentable_class.add_comment(comment)

#   flash[:notice] = "Your comment has been added!"
#   redirect_to :action => "show", :id => params[:id] 
# end    


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:avatar) }
  end
end
