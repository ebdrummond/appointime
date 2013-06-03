class Admin::AppointmentsController < ApplicationController
  before_filter :require_admin

  def clients
    @users = User.basic_search(params[:query])
  end

  def new
    @appointment = Appointment.new
    @user = User.find(params[:user_id])
  end

  def create
    @appointment = Appointment.schedule(params)

    if @appointment.save
      @appointment.send_text_message
      redirect_to admin_appointment_path(@appointment), notice: "Appointment created!"
    else
      redirect_to admin_dashboard_path, notice: "Appointment failed to save"
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    redirect_to admin_dashboard_path,
    notice: "Appointment cancelled"
  end
end