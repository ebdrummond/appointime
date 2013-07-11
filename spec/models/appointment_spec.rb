describe Appointment do
  let(:user){ stub(id: 1) }

  subject do
    Appointment.new(date: Date.new(2013, 6, 6),
                    start: Clock.new(9, 30).time,
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
                :date => "Monday, July 15, 2013",
                :appt_slot => "8, 0",
                :id => subject.id}
      subject.update_info(params)
      expect(subject.date).to eq(Date.new(2013, 7, 15))
    end
  end

  describe ".for_this_week" do
    it "returns the appointments for this current week" do
      Appointment.create(date: Date.today,
                         start: Clock.new(9, 30).time,
                         duration: 90,
                         user_id: user.id)
      Appointment.create(date: Date.today,
                         start: Clock.new(11, 30).time,
                         duration: 90,
                         user_id: user.id)
      expect(Appointment.for_this_week.count).to eq(2)
    end
  end

  describe ".for_next_week" do
    it "returns the appointments for the next week" do
      Appointment.create(date: Date.today + 1.week,
                         start: Clock.new(9, 30).time,
                         duration: 90,
                         user_id: user.id)
      Appointment.create(date: Date.today + 1.week,
                         start: Clock.new(11, 30).time,
                         duration: 90,
                         user_id: user.id)
      expect(Appointment.for_next_week.count).to eq(2)
    end
  end

  describe "#ending" do
    it "returns when the appointment is ending" do
      expect(subject.ending).to eq(Clock.new(11).time)
    end
  end

  describe ".for_this" do
    it "returns the appointments for a given date" do
      Appointment.create(date: Date.today,
                         start: Clock.new(9, 30).time,
                         duration: 90,
                         user_id: user.id)
      Appointment.create(date: Date.today,
                         start: Clock.new(11, 30).time,
                         duration: 90,
                         user_id: user.id)
      expect(Appointment.for_this(Date.today).count).to eq(2)
    end
  end

  describe "#appointment_time" do
    it "returns the full date and time of the appointment's start" do
      expect(subject.appointment_time).to eq("2013-06-06 09:00:00 -0600")
    end
  end

  describe "#seconds_before_appointment" do
    it "returns the seconds between the creation time and the appointment start" do
      appointment = Appointment.create(date: "Thu, 12 Jul 2013",
                                       start: Clock.new(9, 30).time,
                                       duration: 90,
                                       user_id: user.id)
      appointment.created_at = "Thu, 11 Jul 2013 09:30:00 UTC +00:00"
      expect(appointment.seconds_before_appointment).to eq(106200)
    end
  end

  describe "#hours_before_appointment" do
    it "returns the hours between the creation time and the appointment start" do
      appointment = Appointment.create(date: "Thu, 12 Jul 2013",
                                       start: Clock.new(9, 30).time,
                                       duration: 90,
                                       user_id: user.id)
      appointment.created_at = "Thu, 11 Jul 2013 09:30:00 UTC +00:00"
      expect(appointment.hours_before_appointment).to eq(29)
    end
  end

  describe "#text_time" do
    it "returns the time a text message should be sent" do
      appointment = Appointment.create(date: "Thu, 12 Jul 2013",
                                       start: Clock.new(9, 30).time,
                                       duration: 90,
                                       user_id: user.id)
      appointment.created_at = "Thu, 11 Jul 2013 09:30:00 UTC +00:00"
      expect(appointment.text_time).to eq(32)
    end
  end
end
