class Appointment < ActiveRecord::Base
  attr_accessible :start_time,
                  :duration,
                  :user_id

  validates_presence_of :start_time,
                        :duration,
                        :user_id

  belongs_to :user

  def self.schedule(params)
    appointment = Appointment.new
    appointment.start_time = DateTimeParser.new(params[:date], params[:appt_slot]).parse
    appointment.duration = params[:duration]
    appointment.user_id = params[:appointment][:user_id]
    appointment
  end

  def update_info(params)
    self.date = params[:date]
    self.start = Time.parse(params[:appt_slot].gsub(", ", ":"))
    self.duration = params[:duration]
    self
  end

  def pretty_start
    "#{self.date.strftime("%B %-d")} at #{self.start.strftime("%-l:%M")}"
  end

  def self.for_this_week
    Appointment.where(:date => (Date.today.beginning_of_week(start_day = :sunday)..Date.today.end_of_week(start_day = :sunday))).order("date ASC, start ASC")
  end

  def self.for_next_week
    Appointment.where(:date => (Date.today.beginning_of_week(start_day = :sunday) + 7.days..Date.today.end_of_week(start_day = :sunday) + 7.days)).order("date ASC, start ASC")
  end

  def ending
    (Clock.from(self.start_time) + self.duration).time
  end

  def self.find_all_by_date(date)
    dates = Appointment.pluck(:start_time)
    dates.select{|appt_date| appt_date.to_date == date }
  end

  def self.for_this(date)
    Appointment.find_all_by_date(date)
  end

  def self.time_for_appointment_reminder?
    Appointment.where(["appointment_time < ?", (Time.now - 4.hours)])
  end

  def self.text_upcoming_appointments

  end

  def appointment_time
    self.start_time
  end

  def hours_before_appointment
    (seconds_before_appointment / 3600).to_i
  end

  def seconds_before_appointment
    appointment_time - self.created_at
  end

  def text_time
    hours_before_appointment - 4
  end
end
