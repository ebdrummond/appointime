require 'spec_helper'

describe Appointment do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:appointment) { FactoryGirl.create(:appointment, user_id: user.id) }

  it "requires a start" do
    expect{ appointment.start_time = "" }.to change { appointment.valid? }.to be_false
  end

  it "requires a duration" do
    expect{ appointment.duration = "" }.to change { appointment.valid? }.to be_false
  end

  it "requires a user" do
    expect{ appointment.user_id = "" }.to change { appointment.valid? }.to be_false
  end

  describe "#pretty_start" do
    it "has a pretty formatted date" do
      date = Date.today.strftime("%B %-d")
      expect(appointment.pretty_start).to eq("#{date} at 9:30")
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
      params = {:appointment => {:user_id => 1},
                :duration => 60,
                :date => "Wednesday, August 28, 2013",
                :appt_slot => "13, 30",
                :id => appointment.id}
      appointment.update_info(params)
      expect(Clock.from(appointment.start_time)).to eq(Clock.new(13, 30))
    end
  end

  describe ".for_this_week" do
    it "returns the appointments for this current week" do
      FactoryGirl.create(:appointment, user_id: user.id)
      expect(Appointment.for_this_week.count).to eq(2)
    end
  end

  describe ".for_next_week" do
    it "returns the appointments for the next week" do
      2.times do
        FactoryGirl.create(:appointment, user_id: user.id, date: Date.today + 7.days)
      end
      expect(Appointment.for_next_week.count).to eq(2)
    end
  end

  describe "#ending" do
    it "returns when the appointment is ending" do
      expect(appointment.ending).to eq(Clock.new(11).time)
    end
  end

  describe ".for_this" do
    it "returns the appointments for a given date" do
      FactoryGirl.create(:appointment, user_id: user.id)
      expect(Appointment.for_this(Date.today).count).to eq(2)
    end
  end
end
