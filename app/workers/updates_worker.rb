class UpdatesWorker
  include Sidekiq::Worker

  def perform(appointment_id)
    appointment = Appointment.find(appointment_id)

    Emailer.update_email(appointment).deliver
  end
end