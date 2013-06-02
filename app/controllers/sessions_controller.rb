class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin
        redirect_to admin_dashboard_path,
        notice: "Welcome back, #{user.first_name}!"
      else
        redirect_to root_path
      end
    else
      redirect_to :back, error: "Login failed"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end