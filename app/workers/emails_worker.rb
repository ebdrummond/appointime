class EmailsWorker
  include Sidekiq::Worker

  def perform(appointment_id)
    appointment = Appointment.find(appointment_id)

    Emailer.confirmation_email(appointment).deliver
  end
end