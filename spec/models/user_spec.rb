require "spec_helper"

describe User do
  let!(:user) { FactoryGirl.create(:user) }

  it "requires a first name" do
    expect{ user.first_name = "" }.to change { user.valid? }.to be_false
  end

  it "requires a last name" do
    expect{ user.last_name = "" }.to change { user.valid? }.to be_false
  end

  it "requires an email" do
    expect{ user.email = "" }.to change { user.valid? }.to be_false
  end

  it "requires a unique email" do
    user2 = FactoryGirl.build_stubbed(:user)
    expect(user2.valid?).to be_false
  end

  it "requires a password" do
    user2 = FactoryGirl.build_stubbed(:user, password: nil)
    expect(user2.valid?).to be_false
  end

  it "requires a phone number" do
    expect{ user.phone = "" }.to change { user.valid? }.to be_false
  end

  it "rejects a phone number that is not valid" do
    expect{ user.phone = "1234" }.to change { user.valid? }.to be_false
  end

  it "shorts an 11 digit number that starts with 1" do
    user.phone = "12345678912"
    expect(user.valid_phone_number).to eq("2345678912")
  end

  it "merges first and last to create a full name" do
    expect(user.full_name).to eq("Erin Drummond")
  end
end