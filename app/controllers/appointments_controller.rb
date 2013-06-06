class AppointmentsController < ApplicationController

  def new
    @appointment = Appointment.new

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

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    redirect_to admin_dashboard_path,
    notice: "Appointment cancelled"
  end
end