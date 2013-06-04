require "spec_helper"

# describe "an admin adds a new appointment" do
#   let(:admin){ User.create(first_name: "Meghan",
#                            last_name: "Peters",
#                            email: "meghan.peters@gmail.com",
#                            password: "yes",
#                            phone: "1112223333") }
#   let(:user){ User.create(first_name: "Brock",
#                           last_name: "Boland",
#                           email: "brock@gmail.com",
#                           password: "yes",
#                           phone: "2022555854") }
#   before do
#     admin.admin = true
#     admin.save
#     visit root_path
#     click_button("Log in")
#     fill_in("Email", :with => "meghan.peters@gmail.com")
#     fill_in("Password", :with => "yes")
#     click_button("Log in")
#     visit admin_dashboard_path
#   end

#   it "has a button to schedule a new appointment" do
#     expect(page).to have_button("Schedule a new appointment")
#   end

#   it "returns a list of clients matching the search terms" do
#     click_button("Schedule a new appointment")
#     fill_in("query", :with => user.first_name)
#     click_button("Search")
#     expect(page).to have_content("Brock Boland")
#   end

#   it "links to the appointment scheduling page" do
#     click_button("Schedule a new appointment")
#     fill_in("query", :with => user.first_name)
#     click_button("Search")
#     expect(page).to have_content("Brock Boland")
#     click_link("Brock Boland")
#     expect(current_path).to eq(new_admin_appointment_path)
#   end

#   it "schedules the appointment" do
#     click_button("Schedule a new appointment")
#     fill_in("query", :with => user.first_name)
#     click_button("Search")
#     expect(page).to have_content("Brock Boland")
#     click_link("Brock Boland")
#     expect(current_path).to eq(new_admin_appointment_path)
#     fill_in("appt_date", :with => "Thursday, June 6, 2013")
#     fill_in("appt_start", :with => "1:00 PM")
#     choose("appointment_duration_60")
#     expect{ click_button("Book appointment!") }.to change(Appointment, :count).by(1)
#   end
# end