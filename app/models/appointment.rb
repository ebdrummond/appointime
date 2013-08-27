class Appointment < ActiveRecord::Base
  attr_accessible :start_time,
                  :duration,
                  :user_id

  validates_presence_of :start_time,
                        :duration,
                        :user_id

  belongs_to :user

  def ending
    self.start_time.to_time + self.duration.minutes
  end

  def self.schedule(params)
    appointment = Appointment.new
    appointment.start_time = (DateTimeParser.new(params[:date], params[:appt_slot]).parse)
    appointment.duration = params[:duration]
    appointment.user_id = params[:appointment][:user_id]
    appointment
  end

  def update_info(params)
    self.start_time = DateTimeParser.new(params[:date], params[:appt_slot]).parse
    self.duration = params[:duration]
    self
  end

  def pretty_start
    "#{self.start_time.strftime("%B %-d")} at #{self.start_time.to_time.strftime("%-l:%M")}"
  end

  def self.for_this_week
    Appointment.where(:start_time => (Date.today.beginning_of_week(start_day = :sunday)..Date.today.end_of_week(start_day = :sunday))).order("date ASC, start ASC")
  end

  def self.for_next_week
    Appointment.where(:start_time => (Date.today.beginning_of_week(start_day = :sunday) + 7.days..Date.today.end_of_week(start_day = :sunday) + 7.days)).order("date ASC, start ASC")
  end

  def self.find_all_by_date(date)
    dates = Appointment.pluck(:start_time)
    dates.select{|appt_date| appt_date.to_date == date }
  end

  def self.for_this(date)
    Appointment.find_all_by_date(date)
  end
end
