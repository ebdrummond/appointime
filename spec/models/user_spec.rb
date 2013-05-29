require "spec_helper"

describe User do
  subject do
    User.new(first_name: "Meghan",
             last_name: "Peters",
             email: "meghan.peters@gmail.com",
             password: "yes",
             phone: 1112223333)
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
    expect(User.new(:email => "meghan.peters@gmail.com")).to have(1).error_on("password")
  end

  it "requires a password" do
    expect{ subject.password = "" }.to change { subject.valid? }.to be_false
  end

  it "requires a phone number" do
    expect{ subject.phone = "" }.to change { subject.valid? }.to be_false
  end
end