class DayPlanner
  attr_reader :appointments

  def initialize(appointments = [])
    @appointments = appointments.sort_by{|appt| appt.start}
  end

  def time_slots
    unless appointments.empty?
      slots = []
      appointments.each do |appt|
        slots << TimeSlot.new(starts: appt.start, duration: appt.duration)
      end
      unless appointments.count < 2
        slots.concat(gap_slots)
      end
      unless Clock.from(appointments.first.start) == Clock.new(8)
        slots << morning_slot
      end
      unless Clock.from(appointments.last.start + appointments.last.duration * 60).time >= Clock.new(17).time
        slots << afternoon_slot
      end
      slots.reject!{|slot| slot.duration == 0}
      slots.sort_by{|slot| slot.starts.time}
    else
      [TimeSlot.new(starts: Clock.new(8).time, ends: Clock.new(18).time)]
    end
  end

  def morning_slot
    TimeSlot.new(ends: appointments.first.start)
  end

  def afternoon_slot
    TimeSlot.new(starts: appointments.last.start + appointments.last.duration * 60)
  end

  def gap_slots
    slots = []
    appointments.each_with_index do |appt, index|
      break if index == appointments.size - 1
      next_appt = appointments[index+1]
      slots << TimeSlot.new(starts: appt.start + appt.duration * 60, ends: next_appt.start)
    end
    slots
  end

  def appointment_start_times
    appointments.collect do |appt|
      Clock.from(appt.start).to_s
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
      if duration == 60
        iterations = (os.duration / 30 - 1).to_i
      else
        iterations = (os.duration / 30 - 2).to_i
      end
      start = os.starts
      iterations.times do
        slots << TimeSlot.new(starts: start.time + 30, ends: os.ends.time)
        start += 30
      end
    end
    slots.flatten.uniq.sort_by{|s| s.starts.time }
  end
end

