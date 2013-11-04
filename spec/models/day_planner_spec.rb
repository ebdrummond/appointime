require 'spec_helper'

describe DayPlanner do
  let(:user) { FactoryGirl.create(:user) }
  let(:appt1) { FactoryGirl.create(:appointment, start_time: Clock.new(10, 30).time, duration: 90, user: user) }
  let(:appts) { [appt1] }
  let(:day_planner) { DayPlanner.new(appts) }

  it "knows the start time and duration of the appointments" do
    expect(day_planner.appointments.first.start_time).to eq(Clock.new(10, 30).time)
    expect(day_planner.appointments.first.duration).to eq(90)
  end

  it "sorts the time slots by start time" do
    expect(day_planner.time_slots.first.starts).to eq(Clock.new(8))
  end

  it "has start times for the time slots" do
    expect(day_planner.time_slots[1].starts).to eq(Clock.new(10, 30))
  end

  it "has end times for the time slots" do
    expect(day_planner.time_slots[1].ends).to eq(Clock.new(12))
  end

  it "has durations for the time slots" do
    expect(day_planner.time_slots[1].duration).to eq(90)
  end

  it "identifies open time slots" do
    expect(day_planner.open_slots.count).to eq(2)
  end

  context "with a single appointment in the middle of the day" do
    it "has three time slots" do
      expect(day_planner.time_slots.count).to eq(3)
    end
  end

  context "with a single appointment at the beginning of the day" do
    let(:appt1) { FactoryGirl.create(:appointment, start_time: Clock.new(8).time, duration: 90, user: user) }
    let(:appts){ [appt1] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "has two time slots" do
      expect(day_planner.time_slots.count).to eq(2)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots("60").count).to eq(16)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots("90").count).to eq(15)
    end
  end

  context "with a single appointment at the end of the day" do
    let(:appt1){ FactoryGirl.create(:appointment, start_time: Clock.new(16, 30).time, duration: 90, user: user) }
    let(:appts){ [appt1] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "has two time slots" do
      expect(day_planner.time_slots.count).to eq(2)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots("60").count).to eq(16)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots("90").count).to eq(15)
    end
  end

  context "with multiple appointments in the day" do
    let(:appt2){ FactoryGirl.create(:appointment, start_time: Clock.new(8).time, duration: 90, user: user) }
    let(:appts) { [appt1, appt2] }
    let(:day_planner) { DayPlanner.new(appts) }

    it "sorts the appointments by start time" do
      expect(day_planner.appointments).to eq([appt2, appt1])
    end
  end

  context "with three appointments, with gaps in between" do
    let(:appt1){ FactoryGirl.create(:appointment, start_time: Clock.new(11, 30).time, duration: 90, user: user) }
    let(:appt2){ FactoryGirl.create(:appointment, start_time: Clock.new(10).time, duration: 60, user: user) }
    let(:appt3){ FactoryGirl.create(:appointment, start_time: Clock.new(15).time, duration: 90, user: user) }
    let(:appts){ [appt1, appt2, appt3] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "has seven time slots" do
      expect(day_planner.time_slots.count).to eq(7)
    end

    it "identifies open time slots" do
      expect(day_planner.open_slots.count).to eq(3)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots("60").count).to eq(8)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots("90").count).to eq(5)
    end
  end

  context "with three appointments, two back to back" do
    let(:appt1){ FactoryGirl.create(:appointment, start_time: Clock.new(11).time, duration: 90, user: user) }
    let(:appt2){ FactoryGirl.create(:appointment, start_time: Clock.new(10).time, duration: 60, user: user) }
    let(:appt3){ FactoryGirl.create(:appointment, start_time: Clock.new(15).time, duration: 90, user: user) }
    let(:appts){ [appt1, appt2, appt3] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "has six time slots" do
      expect(day_planner.time_slots.count).to eq(6)
    end

    it "identifies open time slots" do
      expect(day_planner.open_slots.count).to eq(3)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots("60").count).to eq(9)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots("90").count).to eq(6)
    end
  end

  context "no appointments scheduled" do
    let(:day_planner){ DayPlanner.new }

    it "has one time slot that starts at 8 and ends at 6" do
      expect(day_planner.time_slots.count).to eq(1)
      expect(day_planner.time_slots.first.starts).to eq(Clock.new(8))
      expect(day_planner.time_slots.first.ends).to eq(Clock.new(18))
    end

    it "identifies open time slots" do
      expect(day_planner.open_slots.count).to eq(1)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots("60").count).to eq(19)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots("90").count).to eq(18)
    end
  end
end