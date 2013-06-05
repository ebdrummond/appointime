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
    appointment = Appointment.new
    appointment.date = params[:date]
    appointment.start = params[:appt_slot].gsub(", ", ":")
    appointment.duration = params[:duration]
    appointment.user_id = params[:appointment][:user_id]
    appointment
  end

  def pretty_start
    "#{self.date.strftime("%B %-d")} at #{self.start.strftime("%-l:%M")}"
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

  def self.for_this_week
    Appointment.where(:date => (Date.today.beginning_of_week(start_day = :sunday)..Date.today.end_of_week(start_day = :sunday))).order("date ASC, start ASC")
  end

  def self.for_next_week
    Appointment.where(:date => (Date.today.beginning_of_week(start_day = :sunday) + 7.days..Date.today.end_of_week(start_day = :sunday) + 7.days)).order("date ASC, start ASC")
  end

  def end
    (Clock.from(self.start) + self.duration).time
  end

  def self.for_this(date)
    Appointment.find_all_by_date(date)
  end
end
