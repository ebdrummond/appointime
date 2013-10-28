require 'spec_helper'

describe TimeSlot do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:appt){ FactoryGirl.create(:appointment, user_id: user.id) }

  context "an appointment time slot" do
    let(:time_slot){ TimeSlot.new(starts: appt.start_time, duration: appt.duration) }

    it "has an end time" do
      expect(time_slot.ends).to eq(Clock.new(11))
    end
  end

  context "an empty time slot at the beginning of the day" do
    let(:time_slot){ TimeSlot.new(ends: appt.start_time) }

    it "starts at 8am" do
      expect(time_slot.starts).to eq(Clock.new(8))
    end

    it "ends at 9:30am" do
      expect(time_slot.ends).to eq(Clock.new(9, 30))
    end

    it "lasts for 90 minutes" do
      expect(time_slot.duration).to eq(90)
    end
  end

  context "an empty slot at the end of the day" do
    let(:start_time){ Clock.new(16, 30).time }
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