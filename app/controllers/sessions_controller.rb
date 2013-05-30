class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.first_name}!"
      if user.admin
        redirect_to admin_dashboard_path
      else
        redirect_to root_path
      end
    else
      flash[:notice] = "Login failed"
      render :new
    end
  end
end