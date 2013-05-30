class Appointment < ActiveRecord::Base
  attr_accessible :date,
                  :start,
                  :ending,
                  :user_id

  validates_presence_of :date,
                        :start,
                        :ending,
                        :user_id

  belongs_to :user

  def self.schedule(params)
    appointment = Appointment.new(params[:appointment])
    appointment.start = DateTime.parse("#{appointment.date}T#{appointment.start.strftime("%H:%M:00")}")
    appointment.ending = appointment.start + params[:ending][0..1].to_i.minutes
    appointment.user_id = params[:user_id]
    appointment
  end

  def pretty_start
    self.start.strftime("%B %-d at %l:%M %P")
  end

  def send_text_message
    client_number = self.user.phone

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = "5864774334"

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => client_number,
      :body => "Hi #{self.user.first_name}!  Just a friendly reminder you have an upcoming appointment at New Leaf Massage on #{self.pretty_start}!")
  end


end
