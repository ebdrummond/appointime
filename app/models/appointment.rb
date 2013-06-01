class Appointment < ActiveRecord::Base
  attr_accessible :date,
                  :start,
                  :duration,
                  :user_id

  validates_presence_of :date,
                        :start,
                        :duration,
                        :user_id

  belongs_to :user

  def self.schedule(params)
    appointment = Appointment.new(params[:appointment])
    appointment.start = Clock.from(Time.parse(appointment.start)).to_s
    appointment.user_id = params[:user_id]
    appointment
  end

  def pretty_start
    "#{self.date.strftime("%B %-d")} at #{Time.parse(self.start).strftime("%-l:%M")}"
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
