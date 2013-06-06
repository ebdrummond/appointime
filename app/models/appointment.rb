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
    appointment.start = Time.parse(params[:appt_slot].gsub(", ", ":"))
    appointment.duration = params[:duration]
    appointment.user_id = params[:appointment][:user_id]
    appointment
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

  def end
    (Clock.from(self.start) + self.duration).time
  end

  def self.for_this(date)
    Appointment.find_all_by_date(date)
  end

  def appointment_time
    self.date.to_time + self.start.hour * 60 * 60
  end

  def hours_before_appointment
    ((appointment_time - self.created_at) / 3600).to_i
  end

  def text_time
    hours_before_appointment - 3
  end
end
