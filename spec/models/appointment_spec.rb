require 'spec_helper'

describe Appointment do
  let(:user){ stub(id: 1) }

  subject do
    Appointment.new(date: Date.new(2013, 6, 6),
                    start: Clock.new(9, 30).to_s,
                    duration: 90,
                    user_id: user.id)
  end

  it "requires a date" do
    expect{ subject.date = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a start" do
    expect{ subject.start = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a duration" do
    expect{ subject.duration = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a user" do
    expect{ subject.user_id = "" }.to change { subject.valid? }.to be_false
  end

  it "has a pretty formatted date" do
    subject.save
    expect(subject.pretty_start).to eq("June 6 at 9:30")
  end
end
