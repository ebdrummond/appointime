require "spec_helper"

describe "an admin adds a new appointment" do
  it "displays a field for a client" do
    visit new_admin_appointment_path
    expect(page).to have_field("client_search")
  end

  it "displays a field for date and time" do

  end

end