describe DayPlanner do
  it "sorts the appointments by start time" do
    appt1 = stub(start: Clock.new(15).time, duration: 90)
    appt2 = stub(start: Clock.new(8).time, duration: 90)
    appts = [appt1, appt2]

    expect(DayPlanner.new(appts).appointments).to eq([appt2, appt1])
  end

  context "with a single appointment in the middle of the day" do
    let(:appt1){ stub(start: Clock.new(10, 30).time, duration: 90) }
    let(:appts){ [appt1] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "takes in appointments" do
      expect(day_planner.appointments).to eq(appts)
    end

    it "knows the start time and duration of the appointments" do
      expect(day_planner.appointments.first.start).to eq(Clock.new(10, 30).time)
      expect(day_planner.appointments.first.duration).to eq(90)
    end

    it "has three time slots" do
      expect(day_planner.time_slots.count).to eq(3)
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
  end

  context "with a single appointment at the beginning of the day" do
    let(:appt1){ stub(start: Clock.new(8).time, duration: 90) }
    let(:appts){ [appt1] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "takes in appointments" do
      expect(day_planner.appointments).to eq(appts)
    end

    it "knows the start time and duration of the appointments" do
      expect(day_planner.appointments.first.start).to eq(Clock.new(8).time)
      expect(day_planner.appointments.first.duration).to eq(90)
    end

    it "has two time slots" do
      expect(day_planner.time_slots.count).to eq(2)
    end

    it "sorts the time slots by start time" do
      expect(day_planner.time_slots.first.starts).to eq(Clock.new(8))
    end

    it "has start times for the time slots" do
      expect(day_planner.time_slots[1].starts).to eq(Clock.new(9, 30))
    end

    it "has end times for the time slots" do
      expect(day_planner.time_slots[1].ends).to eq(Clock.new(18))
    end

    it "has durations for the time slots" do
      expect(day_planner.time_slots[1].duration).to eq(510)
    end

    it "identifies open time slots" do
      expect(day_planner.open_slots.count).to eq(1)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots(60).count).to eq(16)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots(90).count).to eq(15)
    end
  end

  context "with a single appointment at the end of the day" do
    let(:appt1){ stub(start: Clock.new(16, 30).time, duration: 90) }
    let(:appts){ [appt1] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "takes in appointments" do
      expect(day_planner.appointments).to eq(appts)
    end

    it "knows the start time and duration of the appointments" do
      expect(day_planner.appointments.first.start).to eq(Clock.new(16, 30).time)
      expect(day_planner.appointments.first.duration).to eq(90)
    end

    it "has two time slots" do
      expect(day_planner.time_slots.count).to eq(2)
    end

    it "sorts the time slots by start time" do
      expect(day_planner.time_slots.first.starts).to eq(Clock.new(8))
    end

    it "has start times for the time slots" do
      expect(day_planner.time_slots[1].starts).to eq(Clock.new(16, 30))
    end

    it "has end times for the time slots" do
      expect(day_planner.time_slots[1].ends).to eq(Clock.new(18))
    end

    it "has durations for the time slots" do
      expect(day_planner.time_slots[1].duration).to eq(90)
    end

    it "identifies open time slots" do
      expect(day_planner.open_slots.count).to eq(1)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots(60).count).to eq(16)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots(90).count).to eq(15)
    end
  end

  context "with three appointments, with gaps in between" do
    let(:appt1){ stub(start: Clock.new(11, 30).time, duration: 90) }
    let(:appt2){ stub(start: Clock.new(10).time, duration: 60) }
    let(:appt3){ stub(start: Clock.new(15).time, duration: 90) }
    let(:appts){ [appt2, appt1, appt3] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "takes in appointments" do
      expect(day_planner.appointments).to eq(appts)
    end

    it "knows the start time and duration of the appointments" do
      expect(day_planner.appointments.first.start).to eq(Clock.new(10).time)
      expect(day_planner.appointments.first.duration).to eq(60)
    end

    it "has two time slots" do
      expect(day_planner.time_slots.count).to eq(7)
    end

    it "sorts the time slots by start time" do
      expect(day_planner.time_slots.first.starts).to eq(Clock.new(8))
    end

    it "has start times for the time slots" do
      expect(day_planner.time_slots[1].starts).to eq(Clock.new(10))
    end

    it "has end times for the time slots" do
      expect(day_planner.time_slots[1].ends).to eq(Clock.new(11))
    end

    it "has durations for the time slots" do
      expect(day_planner.time_slots[1].duration).to eq(60)
    end

    it "identifies open time slots" do
      expect(day_planner.open_slots.count).to eq(3)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots(60).count).to eq(8)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots(90).count).to eq(5)
    end
  end

  context "with three appointments, two back to back" do
    let(:appt1){ stub(start: Clock.new(11).time, duration: 90) }
    let(:appt2){ stub(start: Clock.new(10).time, duration: 60) }
    let(:appt3){ stub(start: Clock.new(15).time, duration: 90) }
    let(:appts){ [appt2, appt1, appt3] }
    let(:day_planner){ DayPlanner.new(appts) }

    it "takes in appointments" do
      expect(day_planner.appointments).to eq(appts)
    end

    it "knows the start time and duration of the appointments" do
      expect(day_planner.appointments.first.start).to eq(Clock.new(10).time)
      expect(day_planner.appointments.first.duration).to eq(60)
    end

    it "has two time slots" do
      expect(day_planner.time_slots.count).to eq(6)
    end

    it "sorts the time slots by start time" do
      expect(day_planner.time_slots.first.starts).to eq(Clock.new(8))
    end

    it "has start times for the time slots" do
      expect(day_planner.time_slots[1].starts).to eq(Clock.new(10))
    end

    it "has end times for the time slots" do
      expect(day_planner.time_slots[1].ends).to eq(Clock.new(11))
    end

    it "has durations for the time slots" do
      expect(day_planner.time_slots[1].duration).to eq(60)
    end

    it "identifies open time slots" do
      expect(day_planner.open_slots.count).to eq(3)
    end

    it "identifies available appointment slots for 60 minute massages" do
      expect(day_planner.appt_slots(60).count).to eq(9)
    end

    it "identifies available appointment slots for 90 minute massages" do
      expect(day_planner.appt_slots(90).count).to eq(6)
    end
  end
end