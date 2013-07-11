require 'spec_helper'

describe UsersHelper do
  describe "#formatted_phone" do
    it "formats the phone number" do
      expect(helper.formatted_phone("2022555854")).to eq("(202) 255-5854")
    end
  end
end
