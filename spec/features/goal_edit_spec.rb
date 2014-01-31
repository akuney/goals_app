require 'spec_helper'


feature "Edit Goals" do

  describe "goal edit view" do

    before(:each) do
      visit new_user_url
      fill_in "Username", with: "billybob"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"

      click_link "Create New Goal"
      fill_in "Title", with: "Learn to juggle."
      fill_in "Description", with: "Juggle flaming knives by January!!"
      click_button "Create This Goal"

      click_link "Edit Goal"
    end

    it "should be on the edit page" do
      expect(page).to have_content("Edit This Goal")
    end

    it "has the same choices as the new goal page" do
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_content("Private")
      expect(page).to have_content("Public")
    end

    it "should have data prefilled" do
      find_field('Title').value.should eq 'Learn to juggle.'
      find_field('Description').value.should eq 'Juggle flaming knives by January!!'
    end

    it "should let us choose if the goal is completed" do
      expect(page).to have_content("Completion Status")
    end

    it "should have a submission button" do
      expect(page).to have_button("Update This Goal")
    end
  end

  describe "editing a goal" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "billybob"
      fill_in "Password", with: "hotdog"
      click_on "Sign Up"

      click_link "Create New Goal"
      fill_in "Title", with: "Learn to juggle."
      fill_in "Description", with: "Juggle flaming knives by January!!"
      click_button "Create This Goal"

      click_link "Edit Goal"
    end

    it "edits title and redirects to user's goal index" do
      fill_in "Title", with: "Learn to unicycle."
      click_button "Update This Goal"

      expect(page).to have_content("My Goals")
      expect(page).to have_content("Learn to unicycle.")
      expect(page).not_to have_content("Learn to juggle.")
    end

    it "edits description" do
      fill_in "Description", with: "Juggle three balls by February"
      click_button "Update This Goal"

      click_link "Learn to juggle." #click link to show page

      expect(page).to have_content("Juggle three balls by February")
      expect(page).not_to have_content("Juggle flaming knives by January!!")
    end

    it "edits privacy status" do
      choose "Private"
      click_button "Update This Goal"
      click_button "Log Out"

      #sign in as other user
      fill_in "Username", with: "jackiejohn"
      fill_in "Password", with: "yeehaw"
      click_on "Sign Up"
      click_on "Users"
      click_on "billybob"

      expect(page).to have_content("My Goals")
      expect(page).not_to have_content("Learn to juggle.")
    end

    it "edits completion status" do
      choose "Complete"
      click_button "Update This Goal"

      expect(page).to have_content("Complete")
      expect(page).not_to have_content("Incomplete")
    end
  end
end