require "spec_helper"

# describe "when a user signs up with the site" do
#   context "with valid information" do
#     it "adds a user to the database and redirects to root path" do
#     visit signup_path
#     fill_in("First name",   :with => "Nic")
#     fill_in("Last name",    :with => "Peters")
#     fill_in("Email",        :with => "nic@gmail.com")
#     fill_in("user_phone",   :with => "1112223333")
#     fill_in("Password",     :with => "yes")
#     fill_in("Password confirmation", :with => "yes")
#     click_button("Sign up!")
#     expect(current_path).to eq(root_path)
#     expect(page).to have_content("Welcome, Nic!")
#     expect(User.count).to eq(1)
#     end
#   end

#   context "with invalid information" do
#     it "re-renders the signup form and gives errors to user" do
#       visit signup_path
#       fill_in("First name",   :with => "Nic")
#       fill_in("Password",     :with => "yes")
#       fill_in("Password confirmation", :with => "no")
#       click_button("Sign up!")
#       expect(page).to have_content("Last name can't be blank")
#       expect(page).to have_content("Password doesn't match confirmation")
#       expect(page).to have_content("Last name can't be blank")
#       expect(page).to have_content("Email can't be blank")
#       expect(page).to have_content("Phone can't be blank")
#     end
#   end
# end