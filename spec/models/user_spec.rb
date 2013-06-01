require "spec_helper"

describe User do
  subject do
    User.new(first_name: "Meghan",
             last_name: "Peters",
             email: "meghan.peters@gmail.com",
             password: "yes",
             password_confirmation: "yes",
             phone: "1112223333")
  end

  it "requires a first name" do
    expect{ subject.first_name = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a last name" do
    expect{ subject.last_name = "" }.to change { subject.valid? }.to be_false
  end

  it "requires an email" do
    expect{ subject.email = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a unique email" do
    subject.save
    user = User.new(first_name: "Meghan",
                    last_name: "Peters",
                    email: "meghan.peters@gmail.com",
                    password: "yes",
                    phone: "1112223333")
    expect(user).to have(1).error_on("email")
  end

  it "requires a password" do
    expect{ subject.password = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a phone number" do
    expect{ subject.phone = "" }.to change { subject.valid? }.to be_false
  end

  it "rejects a phone number that is not valid" do
    expect{ subject.phone = "1234" }.to change { subject.valid? }.to be_false
  end

  it "shorts an 11 digit number that starts with 1" do
    subject.phone = "12345678912"
    expect(subject.valid_phone_number).to eq("2345678912")
  end

  it "merges first and last to create a full name" do
    expect(subject.full_name).to eq("Meghan Peters")
  end
end