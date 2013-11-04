require 'spec_helper'

describe Emailer do
  let(:user){ FactoryGirl.create(:user) }
  let(:appointment) { FactoryGirl.create(:appointment, user: user) }

  describe "#confirmation_email" do
    let!(:mail) { Emailer.confirmation_email(appointment) }

    it "renders the headers" do
      mail.subject.should eq("Appointment confirmed!")
      mail.to.should eq(["e.b.drummond@gmail.com"])
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
      mail.to.should eq(["e.b.drummond@gmail.com"])
      mail.from.should eq(["newleafmassage1@gmail.com"])
    end

    it "renders the body" do
      mail.body.should include("You have successfully updated")
    end
  end
end
