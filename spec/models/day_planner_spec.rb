require './app/models/day_planner'
require './app/models/time_slot'
require './app/models/clock'

describe DayPlanner do
  let(:appt1){ stub(start_time: Time.new(2013, 1, 1, 10, 30), duration: 90) }
  # let(:appt2){ stub(start_time: Time.new(2013, 1, 1, 15), duration: 90) }
  # let(:appts){ [appt1, appt2] }
  let(:day_planner){ DayPlanner.new(appt1) }

  context "with a single appointment" do
    it "takes in appointments" do
      expect(day_planner.appointments).to eq(appts)
    end

    it "knows the start time and duration of the appointmentss" do
      expect(day_planner.appointments.last.start_time).to eq(Time.new(2013, 1, 1, 15))
      expect(day_planner.appointments.last.duration).to eq(90)
    end

    it "has time slots" do
      expect(day_planner.time_slots.count).to eq(5)
    end
  end

  # it "has start times for the time slots" do
  #   time_slot = DayPlanner.new(appt).time_slots.first
  #   expect(DayPlanner.new(appt).start_time(time_slot)).to eq("09:00")
  # end

  # it "has end times for the time slots" do
  #   time_slot = DayPlanner.new(appt).time_slots.first
  #   expect(DayPlanner.new(appt).end_time(time_slot)).to eq("15:00")
  # end

  # it "has durations for the time slots" do
  #   time_slot = DayPlanner.new(appt).time_slots.first
  #   expect(DayPlanner.new(appt).duration(time_slot)).to eq(360)
  # end

  # it "returns open time slots" do
  #   expect(DayPlanner.new(appt).open_slots.count).to eq(1)
  # end
end


# context - beginning of day 1 appt
# context - middle of day 1 appt
# context - end of day 1 appt
# context - 3 appts with gaps
# context - 2 with no gap