require 'spec_helper'

describe "when a user logs into the site" do
  it "has login fields" do
    visit root_path
    expect(page).to have_content("Welcome to New Leaf Massage")
    expect(page).to have_field("email")
    expect(page).to have_field("password")
  end

  context "as an admin" do
    it "has fields to add appointment times" do

    end
  end
end