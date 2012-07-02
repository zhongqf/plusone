class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  helper_method :admin_controller?
  
  layout :set_layout
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to new_user_session_url
  end

  def admin_controller?
    false
  end
  

  protected
    def set_layout
      case
      when admin_controller? then "admin"
      when devise_controller?  then "login"
      else "application"
      end
    end

end
