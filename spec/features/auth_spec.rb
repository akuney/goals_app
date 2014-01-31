require 'spec_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  it "has a username and password field" do
    visit new_user_url
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  describe "signing up a user successfully" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "testing_username"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"
    end

    it "redirects_to goal index page after signup" do
      expect(page).to have_content "My Goals"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end
  end

  describe "signing up a user unsuccessfully" do
    before(:each) do
      visit new_user_url
    end

    it "does not accept a blank password" do
      fill_in "Username", with: "testing_username"
      click_on "Sign Up"
      expect(page).to have_content "Password is too short"
      expect(page).to have_content "Sign Up"
    end

    it "does not accept a short password" do
      fill_in "Username", with: "testing_username"
      fill_in "Password", with: "short"
      click_on "Sign Up"
      expect(page).to have_content "Password is too short"
      expect(page).to have_content "Sign Up"
    end

    it "does not accept a blank username" do
      fill_in "Password", with: "short"
      click_on "Sign Up"
      expect(page).to have_content "Username can't be blank"
      expect(page).to have_content "Sign Up"
    end
  end
end

feature "logging in" do
  it "has a login page" do
    visit new_session_url
    expect(page).to have_content "Log In"
  end

  it "has a username and password field" do
    visit new_session_url
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  describe "successful login" do

    before(:each) do
      visit new_user_url
      fill_in "Username", with: "testing_username"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"
      click_on "Log Out"
    end
      # do we need to signup a fake user, logout, and then go back to the login page to test this?
    before do
      visit new_session_url
      fill_in "Username", with: "testing_username"
      fill_in "Password", with: "hotdog"
      click_on "Log In"
    end

    it "directs user to goal index page and displays username" do
      expect(page).to have_content("My Goals")
      expect(page).to have_content("testing_username")
    end
  end

  describe "unsuccessful login" do
    before do
      visit new_session_url
      fill_in "Username", with: "testing_username"
      click_on "Log In"
    end

    it "does not accept a blank password" do
      expect(page).to have_content "incorrect username/password"
      expect(page).to have_content "Log In"
    end

    before do
      visit new_session_url
      fill_in "Username", with: "testing_username"
      fill_in "Password", with: "short"
      click_on "Log In"
    end

    it "does not accept a short password" do
      expect(page).to have_content "incorrect username/password"
      expect(page).to have_content "Log In"
    end

    before do
      visit new_session_url
      fill_in "Password", with: "short"
      click_on "Log In"
    end

    it "does not accept a blank username" do
      expect(page).to have_content "incorrect username/password"
      expect(page).to have_content "Log In"
    end

    before do
      visit new_session_url
      fill_in "Username", with: "testing_username"
      fill_in "Password", with: "hotdog"
      click_on "Log In"
    end

    it "doesn't accept a not-signed-up user with legal information" do
      expect(page).to have_content "Log In"
    end
  end
end

feature "logging out" do
  it "should prohibit logged-out users from setting new goals" do
    visit new_user_goal_url(4) #may be nested under user
    expect(page).to have_content "Please sign in first."
    expect(page).to have_content "Log In"
  end


  it "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in "Username", with: "testing_username"
    fill_in "Password", with: "hotdog"
    click_on "Sign Up"
    click_button "Log Out"
    # learned below syntax on stackoverflow. need to verify
    expect(page).should_not have_content "testing_username"
  end
end