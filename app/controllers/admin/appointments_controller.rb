class Admin::AppointmentsController < ApplicationController
  before_filter :require_admin

  def clients
    @users = User.search_by_full_name_or_email(params[:query])

    respond_to do |format|
      format.html

      format.json do
        @users = @users.map do |user|
          { full_name: user.full_name,
            email: user.email,
            appointment_path: new_admin_appointment_path(user_id: user.id) }
        end

        render json: @users
      end
    end
  end

  def new
    @appointment = Appointment.new
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html

      format.json do
        @appointments = Appointment.for_this(Date.parse(params[:date]))
        @open_slots = DayPlanner.new(@appointments).appt_slots(params[:duration])

        render json: @open_slots
      end
    end
  end

  def create
    @appointment = Appointment.schedule(params)

    if @appointment.save
      EmailsWorker.perform_async(@appointment.id)
      TextsWorker.perform_in(@appointment.text_time.hours, @appointment.id)
      redirect_to admin_appointment_path(@appointment), notice: "Appointment created!"
    else
      redirect_to admin_dashboard_path, notice: "Appointment failed to save"
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @user = @appointment.user

    respond_to do |format|
      format.html

      format.json do
        @appointments = Appointment.for_this(Date.parse(params[:date]))
        @open_slots = DayPlanner.new(@appointments).appt_slots(params[:duration])

        render json: @open_slots
      end
    end
  end

  def update
    @appointment = Appointment.find(params[:id])

    @appointment.update_info(params)

    if @appointment.save
      UpdatesWorker.perform_async(@appointment.id)
      TextsWorker.perform_in(@appointment.text_time.hours, @appointment.id)
      redirect_to admin_appointment_path(@appointment), notice: "Appointment updated!"
    else
      redirect_to admin_dashboard_path, notice: "Appointment failed to save"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    redirect_to admin_dashboard_path,
    notice: "Appointment cancelled"
  end
end