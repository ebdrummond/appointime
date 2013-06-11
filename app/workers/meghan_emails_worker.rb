class MeghanEmailsWorker
  include Sidekiq::Worker

  def perform(appointment_id)
    appointment = Appointment.find(appointment_id)

    Emailer.meghan_confirmation_email(appointment).deliver
  end
end