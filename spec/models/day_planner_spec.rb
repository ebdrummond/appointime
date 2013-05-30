require './app/models/day_planner'

describe DayPlanner do
  let(:appt){ stub(start_time: Time.new(2013, 1, 1, 15), duration: 90) }

  it "takes in appointments" do
    expect(DayPlanner.new(appt).appointments).to eq([appt])
  end

  it "knows the start time and duration of the appointmentss" do
    expect(DayPlanner.new(appt).appointment.start_time).to eq(Time.new(2013, 1, 1, 15))
    expect(DayPlanner.new(appt).appointment.duration).to eq(90)
  end

  it "has time slots" do
    expect(DayPlanner.new(appt).time_slots.count).to eq(3)
  end

  it "has start times for the time slots" do
    time_slot = DayPlanner.new(appt).time_slots.first
    expect(DayPlanner.new(appt).start_time(time_slot)).to eq("09:00")
  end

  it "has end times for the time slots" do
    time_slot = DayPlanner.new(appt).time_slots.first
    expect(DayPlanner.new(appt).end_time(time_slot)).to eq("15:00")
  end

  it "has durations for the time slots" do
    time_slot = DayPlanner.new(appt).time_slots.first
    expect(DayPlanner.new(appt).duration(time_slot)).to eq(360)
  end

  it "returns open time slots" do
    expect(DayPlanner.new(appt).open_slots.count).to eq(1)
  end
end