require 'spec_helper'

describe "a user schedules an appointment", :js => true do
  self.use_transactional_fixtures = false
  before do
    @user = User.create(first_name: "Erin",
                       last_name: "Drummond",
                       email: "erin@gmail.com",
                       password: "yes",
                       password_confirmation: "yes",
                       phone: "1112223333")
    visit login_path
    fill_in("Email", with: @user.email)
    fill_in("Password", with: @user.password)
    click_button("Log in")
  end

  context "scheduling an appointment with valid information" do
    xit "schedules an appointment for the user" do
      visit new_appointment_path
      choose("duration_60")
      select("1374040800000", from: "picker__table")
      save_and_open_page
      choose("8:00")
      click_button("Book appointment!")
      expect(page).to have_content("yes")
    end
  end
end