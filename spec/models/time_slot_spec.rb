require './app/models/time_slot'

describe TimeSlot do
  let(:appt){ stub(start_time: Time.new(2013, 1, 1, 15), duration: 90) }
  let(:appt_time_slot){ TimeSlot.new(starts: appt.start_time, duration: appt.duration) }

  it "has an end time" do
    expect(appt_time_slot.ends).to eq(Time.new(2013, 1, 1, 16, 30))
  end

  it ""

end