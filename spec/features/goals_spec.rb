require 'spec_helper'

feature "Goals" do

  describe "goal index page" do

    before(:each) do
      visit new_user_url
      fill_in "Username", with: "billybob"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"
    end

    it "has the correct heading" do
      expect(page).to have_content("billybob")
      expect(page).to have_content("My Goals")
    end

    it "has a new goals link" do
      expect(page).to have_content("Create New Goal")
    end
  end

  describe "new goal page" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "billybob"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"
      click_link "Create New Goal"
    end

    it "new goals link should take you to new goals page" do
      expect(page).to have_content("New Goal")
    end

    it "has title, description, and privacy setting" do
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_content("Private")
      expect(page).to have_content("Public")
    end

    it "has a goal creation button" do
      expect(page).to have_button("Create This Goal")
    end
  end

  describe "successful goal creation (with default public)" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "billybob"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"

      click_link "Create New Goal"
      fill_in "Title", with: "Learn to juggle."
      fill_in "Description", with: "Juggle flaming knives by January!!"
      click_button "Create This Goal"
    end

    it "We are redirected back to the index page" do
      expect(page).to have_content("My Goals")
      expect(page).to have_content("Learn to juggle.")
    end

    it "Other users can see public goals" do
      click_button "Log Out"
      click_link "Sign Me Up"

      fill_in "Username", with: "jackiejohn"
      fill_in "Password", with: "yeehaw"
      click_on "Sign Up"

      click_on "Users"
      click_on "billybob"

      expect(page).to have_content("Learn to juggle.")
    end
  end

  describe "unsuccessful goal creation" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "billybob"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"

      click_link "Create New Goal"
      fill_in "Description", with: "Juggle flaming knives by January!!"
      click_button "Create This Goal"
    end

    it "should redirect back to the new goal page and render error" do
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("New Goal")
    end

    it "previous information has been prefilled" do
      find_field('Description').value.should eq 'Juggle flaming knives by January!!'
    end
  end

  describe "creating private goals" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "billybob"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"

      click_link "Create New Goal"
      fill_in "Title", with: "Learn Mandarin."
      fill_in "Description", with: "Because I'm a super secret agent."
      choose "Private"
      click_button "Create This Goal"
    end

    it "we should be able to see the goal we just made" do
      expect(page).to have_content("Learn Mandarin.")
    end

    it "other people can't see the goal we just made" do
      click_button "Log Out"
      click_link "Sign Me Up"

      fill_in "Username", with: "jackiejohn"
      fill_in "Password", with: "yeehaw"
      click_on "Sign Up"

      click_on "Users"
      click_on "billybob"

      expect(page).to_not have_content("Learn Mandarin.")
    end
  end
end