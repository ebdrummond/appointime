class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :require_admin

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_admin
    redirect_to root_path,
    notice: "Not authorized to access admin section" if !current_user.admin
  end
end
