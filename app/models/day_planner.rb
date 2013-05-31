require 'time'
require 'pry'

class DayPlanner
  attr_reader :appointments

  def initialize(appointments)
    @appointments = appointments.sort_by{|appt| appt.start_time}
  end

  def time_slots
    slots = []
    appointments.each do |appt|
      slots << TimeSlot.new(starts: appt.start_time, duration: appt.duration)
    end
    unless Clock.from(appointments.first.start_time) == Clock.new(8)
      slots << morning_slot
    end
    unless Clock.from(appointments.last.start_time + appointments.last.duration * 60).time >= Clock.new(17).time
      slots << afternoon_slot
    end
    slots.sort_by{|slot| slot.starts.time}
  end

  def morning_slot
    TimeSlot.new(ends: appointments.first.start_time)
  end

  def afternoon_slot
    TimeSlot.new(starts: appointments.last.start_time + appointments.last.duration * 60)
  end

  def appointment_start_times
    appointments.collect{|appt| Clock.new(appt.start_time.hour, appt.start_time.min).to_s}
  end

  def time_slot_start_times
    time_slots.collect{|ts| ts.starts.to_s}
  end

  def open_slots
    time_slots.select{|ts| (time_slot_start_times - appointment_start_times).include?(ts.starts.to_s)}
  end

    # unless appointments.first.start_time.to_s.include?(Clock.new(8).to_s)


    # slots = []
    # appointments.each do |appt|
    #   slots << TimeSlot.new(starts: appt.start_time, duration: appt.duration)
    # end
    # slots << morning_slot
    # slots.concat(in_between_slots)
    # slots << afternoon_slot
    # slots



  # def in_between_slots
  #   slots = []
  #   appointments.each_with_index do |appt, index|
  #     break if index == appointments.size - 1
  #     next_appt = appointments[index+1]
  #     slots << TimeSlot.new(starts: appt.start_time + appt.duration * 60, ends: next_appt.start_time)
  #   end
  #   slots
  # end

  # def initialize(appointment)
  #   @appointment = appointment
  #   @day_start = Time.new(2013, 1, 1, 9)
  #   @day_end = Time.new(2013, 1, 1, 16)
  # end

  # def time_slots
  #   slots = []
  #   slots << "#{day_start.strftime("%H:%M")} to #{appointment.start_time.strftime("%H:%M")}"
  #   slots << "#{appointment.start_time.strftime("%H:%M")} to #{(appointment.start_time + (appointment.duration * 60)).strftime("%H:%M")}"
  #   slots << "#{(appointment.start_time + (appointment.duration * 60)).strftime("%H:%M")} to #{day_end.strftime("%H:%M")}"
  # end

  # def start_time(time_slot)
  #   time_slot.split(" to ").first
  # end

  # def end_time(time_slot)
  #   time_slot.split(" to ").last
  # end

  # def duration(time_slot)
  #   (Time.parse(end_time(time_slot)) - Time.parse(start_time(time_slot)))/60
  # end

  # def open_slots
  #   time_slots.select{|ts| !appointment.start_time.to_s.include?(start_time(ts))  && duration(ts) >= 60}
  # end
end

