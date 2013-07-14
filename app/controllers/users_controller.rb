class UsersController < ApplicationController
  before_filter :authorize_access, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{@user.first_name}!"
    else
      flash[:error] = "Signup failed"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @appointments = @user.appointments.sort_by{|a| a.appointment_time}
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to user_path(@user), notice: "Profile updated."
    else
      redirect_to edit_user_path(@user), notice: "Update failed"
    end
  end

  def destroy

  end

  def authorize_access
    @user = User.find(params[:id])
    if current_user == nil || (@user != current_user unless current_user.admin)
      flash[:error] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end
end
