require 'spec_helper'

describe ApplicationHelper do
  describe "#formatted" do
    context "with a Date" do
      it "formats the date" do
        expect(helper.formatted(Date.new(2013, 7, 10))).to eq("July 10")
      end
    end

    context "with a DateTime" do
      it "formats the datetime" do
        expect(helper.formatted(DateTime.new(2013, 7, 10))).to eq("12:00")
      end
    end

    context "with a Time" do
      it "formats the time" do
        expect(helper.formatted(Time.new(2013, 7, 10))).to eq("12:00")
      end
    end
  end
end