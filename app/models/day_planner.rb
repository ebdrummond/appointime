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
    unless appointments.count < 2
      slots.concat(gap_slots)
    end
    unless Clock.from(appointments.first.start_time) == Clock.new(8)
      slots << morning_slot
    end
    unless Clock.from(appointments.last.start_time + appointments.last.duration * 60).time >= Clock.new(17).time
      slots << afternoon_slot
    end
    slots.reject!{|slot| slot.duration == 0}
    slots.sort_by{|slot| slot.starts.time}
  end

  def morning_slot
    TimeSlot.new(ends: appointments.first.start_time)
  end

  def afternoon_slot
    TimeSlot.new(starts: appointments.last.start_time + appointments.last.duration * 60)
  end

  def gap_slots
    slots = []
    appointments.each_with_index do |appt, index|
      break if index == appointments.size - 1
      next_appt = appointments[index+1]
      slots << TimeSlot.new(starts: appt.start_time + appt.duration * 60, ends: next_appt.start_time)
    end
    slots
  end

  def appointment_start_times
    appointments.collect{|appt| Clock.new(appt.start_time.hour, appt.start_time.min).to_s}
  end

  def time_slot_start_times
    time_slots.collect{|ts| ts.starts.to_s}
  end

  def open_slots
    time_slots.select{|ts| (time_slot_start_times - appointment_start_times).include?(ts.starts.to_s) && ts.duration >= 60}
  end
end

