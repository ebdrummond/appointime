require 'spec_helper'

describe Appointment do
  let(:user){ stub(id: 1) }

  subject do
    Appointment.new(start_time: DateTime.new(2013, 6, 6, 9, 30),
                    duration: 90,
                    user_id: user.id)
  end

  it "requires a start" do
    expect{ subject.start_time = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a duration" do
    expect{ subject.duration = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a user" do
    expect{ subject.user_id = "" }.to change { subject.valid? }.to be_false
  end

  describe "#pretty_start" do
    it "has a pretty formatted date" do
      subject.save
      expect(subject.pretty_start).to eq("June 6 at 9:30")
    end
  end

  describe ".schedule" do
    it "creates a new appointment" do
      params = {:appointment => {:user_id => 2},
                :duration => 60,
                :date => "Wednesday, July 17, 2013",
                :appt_slot =>"16, 30"}
      expect{ Appointment.schedule(params).save }.to change(Appointment, :count).by(1)
    end
  end

  describe "#update_info" do
    it "updates the appointment" do
      subject.save
      params = {:appointment => {:user_id => 1},
                :duration => 60,
                :date => "Wednesday, August 28, 2013",
                :appt_slot => "13, 30",
                :id => subject.id}
      subject.update_info(params)
      expect(subject.start_time).to eq(DateTime.new(2013, 8, 28, 13, 30))
    end
  end

  describe ".for_this_week" do
    it "returns the appointments for this current week" do
      Appointment.create(start_time: DateTime.new(2013, 8, 27, 13, 30),
                         duration: 90,
                         user_id: user.id)
      Appointment.create(start_time: DateTime.new(2013, 8, 28, 7, 8),
                         duration: 90,
                         user_id: user.id)
      expect(Appointment.for_this_week.count).to eq(2)
    end
  end

  describe ".for_next_week" do
    it "returns the appointments for the next week" do
      Appointment.create(start_time: Date.today.to_datetime + 1.week,
                         duration: 90,
                         user_id: user.id)
      Appointment.create(start_time: Date.today.to_datetime + 8.days,
                         duration: 90,
                         user_id: user.id)
      expect(Appointment.for_next_week.count).to eq(2)
    end
  end

  describe "#ending" do
    it "returns when the appointment is ending" do
      expect(subject.ending).to eq(DateTime.new(2013, 6, 6, 11))
    end
  end

  describe ".for_this" do
    it "returns the appointments for a given date" do
      Appointment.create(start_time: DateTime.now,
                         duration: 90,
                         user_id: user.id)
      Appointment.create(start_time: DateTime.now + 1.hour,
                         duration: 90,
                         user_id: user.id)
      expect(Appointment.for_this(Date.today).count).to eq(2)
    end
  end
end
