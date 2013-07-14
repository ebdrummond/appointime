describe Emailer do
  let(:user){ User.create(first_name: "Brock",
                          last_name: "Boland",
                          email: "brock@gmail.com",
                          password: "yes",
                          phone: "2022555854") }
  let(:appointment) { Appointment.create(date: Date.new(2013, 7, 10),
                                         user_id: user.id,
                                         duration: 90,
                                         start: Clock.new(11).time) }

  describe "#confirmation_email" do
    let!(:mail) {Emailer.confirmation_email(appointment)}

    it "renders the headers" do
      mail.subject.should eq("Appointment confirmed!")
      mail.to.should eq(["brock@gmail.com"])
      mail.from.should eq(["newleafmassage1@gmail.com"])
    end

    it "renders the body" do
      mail.body.should include(appointment.pretty_start)
    end
  end

  describe "#meghan_confirmation_email" do
    let!(:mail) {Emailer.meghan_confirmation_email(appointment)}

    it "renders the headers" do
      mail.subject.should eq("Fake appointment scheduled!")
      mail.to.should eq(["newleafmassageandwellness@gmail.com"])
      mail.from.should eq(["newleafmassage1@gmail.com"])
    end

    it "renders the body" do
      mail.body.should include(appointment.pretty_start)
    end
  end

  describe "#update_email" do
    let!(:mail) {Emailer.update_email(appointment)}

    it "renders the headers" do
      mail.subject.should eq("Appointment updated!")
      mail.to.should eq(["brock@gmail.com"])
      mail.from.should eq(["newleafmassage1@gmail.com"])
    end

    it "renders the body" do
      mail.body.should include("You have successfully updated")
    end
  end
end
