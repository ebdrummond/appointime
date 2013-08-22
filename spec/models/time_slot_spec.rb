describe TimeSlot do
  let(:appt){ stub(start_time: DateTime.new(2013, 1, 1, 15), duration: 90) }

  context "an appointment time slot" do
    let(:time_slot){ TimeSlot.new(starts: appt.start_time, duration: appt.duration) }

    it "has an end time" do
      expect(time_slot.ends).to eq(Clock.new(16, 30))
    end
  end

  context "an empty time slot at the beginning of the day" do
    let(:time_slot){ TimeSlot.new(ends: appt.start_time) }

    it "starts at 8am" do
      expect(time_slot.starts).to eq(Clock.new(8))
    end

    it "ends at 3pm" do
      expect(time_slot.ends).to eq(Clock.new(15))
    end

    it "lasts for 420 minutes" do
      expect(time_slot.duration).to eq(420)
    end
  end

  context "an empty slot at the end of the day" do
    let(:start_time){ DateTime.new(2013, 1, 1, 16, 30) }
    let(:time_slot){ TimeSlot.new(starts: start_time) }

    it "starts at 4:30pm" do
      expect(time_slot.starts).to eq(Clock.new(16, 30))
    end

    it "ends at 6:00pm" do
      expect(time_slot.ends).to eq(Clock.new(18))
    end

    it "lasts for 90 minutes" do
      expect(time_slot.duration).to eq(90)
    end
  end

  it "time slots with equal data are equal" do
    slot1 = TimeSlot.new(starts: appt.start_time)
    slot2 = TimeSlot.new(starts: appt.start_time)
    expect(slot1).to eq(slot2)
  end
end