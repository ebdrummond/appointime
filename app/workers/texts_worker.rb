class TextsWorker
  include Sidekiq::Worker

  def perform(appointment_id)
    appointment = Appointment.find(appointment_id)

    client_number = appointment.user.phone

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = "5864774334"

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => client_number,
      :body => "Hi #{appointment.user.first_name}!  Just a friendly reminder you have an upcoming appointment at New Leaf Massage on #{appointment.pretty_start}")
  end
end