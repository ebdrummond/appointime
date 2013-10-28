require 'spec_helper'

describe "a user updates their information" do
  before do
    visit login_path
    @user = User.create(first_name: "Nicolas",
                       last_name: "Peters",
                       email: "nicolas.peters@gmail.com",
                       password: "yes",
                       phone: "1112223333")
    fill_in("Email", with: @user.email)
    fill_in("Password", with: @user.password)
    click_button("Log in")
  end

  context "as a user updating their own information" do

    xit "shows the user their current information" do
      visit user_path(@user)
      expect(page).to have_content("Nicolas Peters")
      expect(page).to have_content("nicolas.peters@gmail.com")
      expect(page).to have_content("(111) 222-3333")
      expect(page).to have_button("Edit my info")
    end

    xit "allows the user to edit their personal information with valid information" do
      visit user_path(@user)
      click_button("Edit my info")
      fill_in("First name", with: "Nic")
      fill_in("Email", with: "nic.peters@gmail.com")
      click_button("Submit")
      expect(page).to have_content("Profile updated")
      expect(page).to have_content("nic.peters@gmail.com")
      expect(page).to_not have_content("Nicolas")
    end

    xit "throws an error when a user tries to edit their information with invalid information" do
      visit user_path(@user)
      click_button("Edit my info")
      fill_in("First name", with: "")
      click_button("Submit")
      expect(page).to have_content("Update failed")
      expect(page).to have_content("Nicolas")
      expect(current_path).to eq(edit_user_path(@user))
    end
  end

  context "as an admin updating another user's information" do
    let!(:user2) { User.create(first_name: "Brock",
                              last_name: "Boland",
                              email: "brock@gmail.com",
                              password: "yes",
                              phone: "1112223333") }

    xit "allows the admin to edit the user's information with valid information" do
      @user.admin = true
      @user.save
      visit user_path(user2)
      click_button("Edit my info")
      fill_in("First name", with: "Randy")
      fill_in("Email", with: "randy@gmail.com")
      click_button("Submit")
      expect(page).to have_content("Profile updated")
      expect(page).to have_content("randy@gmail.com")
      expect(page).to_not have_content("Brock")
    end
  end

  context "as a non-admin user attempting to view another user's information" do
    let!(:user2) { User.create(first_name: "Brock",
                              last_name: "Boland",
                              email: "brock@gmail.com",
                              password: "yes",
                              phone: "1112223333") }

    xit "does not allow the user to view another user's information" do
      visit user_path(user2)
      expect(page).to have_content("You are not authorized to view this page")
    end
  end
end