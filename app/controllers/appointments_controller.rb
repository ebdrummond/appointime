class AppointmentsController < ApplicationController
  before_filter :authorize_access, except: [:new, :create]

  def new
    if current_user
      @appointment = Appointment.new

      respond_to do |format|
        format.html

        format.json do
          @appointments = Appointment.for_this(Date.parse(params[:date]))
          @open_slots = DayPlanner.new(@appointments).appt_slots(params[:duration])

          render json: @open_slots
        end
      end
    else
      redirect_to login_path, notice: "You must be logged in to book an appointment."
    end
  end

  def create
    @appointment = Appointment.schedule(params)

    if @appointment.save
      EmailsWorker.perform_async(@appointment.id)
      TextsWorker.perform_in(@appointment.text_time.hours, @appointment.id)
      redirect_to appointment_path(@appointment), notice: "Appointment created!"
    else
      redirect_to new_appointment_path, notice: "Appointment failed to save."
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
      redirect_to appointment_path(@appointment), notice: "Appointment updated!"
    else
      redirect_to edit_appointment_path, notice: "Appointment failed to save"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    redirect_to user_path(@appointment.user.id),
    notice: "Appointment cancelled"
  end

  def authorize_access
    appointment = Appointment.find(params[:id])
    if current_user == nil || (appointment.user != current_user unless current_user.admin)
      flash[:error] = "You are not authorized to view this page; you may need to log in."
      redirect_to root_path
    end
  end
end