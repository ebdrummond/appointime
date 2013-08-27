class DayPlanner
  attr_reader :appointments

  def initialize(appointments = [])
    @appointments = appointments.sort_by{|appt| appt.start_time}
  end

  def time_slots
    unless appointments.empty?
      slots = []
      slots.concat(appointment_slots)
      slots.concat(gap_slots) unless appointments.count < 2
      slots << morning_slot unless Clock.from(appointments.first.start_time) == Clock.new(8)
      slots << afternoon_slot unless Clock.from(appointments.last.ending).time >= Clock.new(17).time

      slots.sort_by{|slot| slot.starts.time}
    else
      [TimeSlot.new(starts: Clock.new(8).time, ends: Clock.new(18).time)]
    end
  end

  def appointment_slots
    slots = []
    appointments.each do |appt|
        slots << TimeSlot.new(starts: appt.start_time, duration: appt.duration)
    end
    slots
  end

  def morning_slot
    TimeSlot.new(ends: appointments.first.start_time)
  end

  def afternoon_slot
    TimeSlot.new(starts: appointments.last.ending)
  end

  def gap_slots
    slots = []
    appointments.each_with_index do |appt, index|
      break if index == appointments.size - 1
      next_appt = appointments[index+1]
      if appt.ending != next_appt.start_time
        slots << TimeSlot.new(starts: appt.start_time + appt.duration.minutes, ends: next_appt.start_time)
      end
    end
    slots
  end

  def appointment_start_times
    appointments.collect do |appt|
      Clock.from(appt.start_time.to_time).to_s
    end
  end

  def time_slot_start_times
    time_slots.collect{|ts| ts.starts.to_s}
  end

  def open_slots
    time_slots.select{|ts| (time_slot_start_times - appointment_start_times).include?(ts.starts.to_s) && ts.duration >= 60}
  end

  def appt_slots(duration)
    slots = []
    open_slots.each do |os|
      if duration == "60"
        iterations = (os.duration / 30 - 1).to_i
      else
        iterations = (os.duration / 30 - 2).to_i
      end
      slots << create_appt_intervals(os, iterations)
    end
    slots.flatten.sort_by{|s| s.starts.time }
  end

  def create_appt_intervals(slot, iterations)
    slots = []
    start = slot.starts
    iterations.times do
      slots << TimeSlot.new(starts: start.time + 30, ends: slot.ends.time)
      start += 30
    end
    slots
  end
end

