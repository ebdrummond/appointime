require 'spec_helper'

describe Clock do
  it "can take in just an hour" do
    expect(Clock.new(15).to_s).to eq("15:00")
  end

  it "can take in an hour and minutes" do
    expect(Clock.new(15, 30).to_s).to eq("15:30")
  end

  it "can take in an hour and minutes as a string" do
    expect(Clock.new("15, 30").to_s).to eq("15:30")
  end

  it "can add minutes to a clock" do
    new_clock = Clock.new(10) + 90
    expect(new_clock.to_s).to eq("11:30")
  end

  it "can subtract minutes from a clock" do
    new_clock = Clock.new(10) - 90
    expect(new_clock.to_s).to eq("08:30")
  end

  it "can test for equivalency" do
    clock1 = Clock.new(10, 37)
    clock2 = Clock.new(10, 37)
    expect(clock1).to eq(clock2)
  end

  it "can create a clock from a time object" do
    expect(Clock.from(Time.new(2013, 1, 1, 8, 17))).to eq(Clock.new(8, 17))
  end

  it "can subtract another clock" do
    clock1 = Clock.new(10, 20)
    clock2 = Clock.new(11, 15)
    expect(clock2 - clock1).to eq(55)
    expect(clock1 - clock2).to eq(-55)
  end
end