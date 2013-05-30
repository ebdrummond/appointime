class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{@user.first_name}!"
    else
      flash[:notice] = "Signup failed"
      render :new
    end
  end

  def index
    @users = User.all
  end
end
