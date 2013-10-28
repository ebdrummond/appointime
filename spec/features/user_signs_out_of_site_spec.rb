require "spec_helper"

describe "when a user logs out of the site" do
  before do
    visit login_path
    @user = User.create(first_name: "Meghan",
                       last_name: "Peters",
                       email: "meghan.peters@gmail.com",
                       password: "yes",
                       phone: "1112223333")
    fill_in("Email", with: @user.email)
    fill_in("Password", with: @user.password)
    click_button("Log in")
  end

  xit "logs the user out of the site" do
    click_link("Log out")
    expect(page).to have_content("Logged out")
    expect(current_path).to eq(root_path)
  end
end