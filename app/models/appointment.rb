class Appointment < ActiveRecord::Base
  attr_accessible :start_time,
                  :date,
                  :duration,
                  :user_id

  validates_presence_of :start_time,
                        :date,
                        :duration,
                        :user_id

  belongs_to :user

  def ending
    self.start_time.to_time + self.duration.minutes
  end

  def self.schedule(params)
    appointment = Appointment.new
    appointment.start_time = Clock.new(params[:appt_slot]).time
    appointment.date = Date.parse(params[:date])
    appointment.duration = params[:duration]
    appointment.user_id = params[:appointment][:user_id]
    appointment
  end

  def update_info(params)
    self.start_time = Clock.new(params[:appt_slot]).time
    self.date = Date.parse(params[:date])
    self.duration = params[:duration]
    self.save
    self
  end

  def pretty_start
    "#{self.date.strftime("%B %-d")} at #{self.start_time.strftime("%-l:%M")}"
  end

  def self.for_this_week
    Appointment.where(:date => (Date.today.beginning_of_week(start_day = :sunday)..Date.today.end_of_week(start_day = :sunday))).order("date ASC, start ASC")
  end

  def self.for_next_week
    Appointment.where(:date => (Date.today.beginning_of_week(start_day = :sunday) + 7.days..Date.today.end_of_week(start_day = :sunday) + 7.days)).order("date ASC, start ASC")
  end

  def self.for_this(date)
    Appointment.where(date: date)
  end
end
