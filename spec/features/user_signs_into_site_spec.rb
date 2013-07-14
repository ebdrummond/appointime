require "spec_helper"

describe "when a user logs into the site" do
  before do
    visit login_path
    @user = User.create(first_name: "Meghan",
                       last_name: "Peters",
                       email: "meghan.peters@gmail.com",
                       password: "yes",
                       phone: "1112223333")
    fill_in("Email", with: @user.email)
    fill_in("Password", with: @user.password)
  end

  context "as an admin with valid login credentials" do
    it "logs the admin in" do
      @user.admin = true
      @user.save
      click_button("Log in")
      expect(current_path).to eq(admin_dashboard_path)
    end
  end

  context "as a regular user with valid login credentials" do
    it "logs the user in" do
      click_button("Log in")
      expect(current_path).to eq(root_path)
    end
  end

  context "as a user with invalid login credentials" do
    it "re-renders the login form" do
      fill_in("Email", with: "hooey!")
      click_button("Log in")
      expect(page).to have_content("Login failed")
    end
  end

  context "as a regular user trying to access the admin page" do
    it "redirects the user with an error" do
      click_button("Log in")
      visit admin_dashboard_path
      expect(page).to have_content("Not authorized")
      expect(current_path).to eq(root_path)
    end
  end
end