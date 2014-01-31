require 'spec_helper'

describe User do

  context "without name" do
    let(:incomplete_user) { User.new }

    it "validates presence of username" do
      expect(incomplete_user).to have(1).error_on(:username)
    end

    it "should have a session token upon initialization" do
      # tests after_intialize callback
      expect(incomplete_user.session_token).not_to be_nil
    end
  end

  context "with name" do

    let!(:user1) do
       User.create!({username: "billybob", password: "hotdog"})
    end

    it "validates uniqueness of username" do
      user2 = User.new({username: "billybob", password: "hamburger"})
      expect(user2).not_to be_valid
    end

    it "should have a password digest" do
      expect(user1.password_digest).not_to be_nil
    end

    it "should not store password" do
      expect(user1.password).to be_nil
    end
  end

  context "helper methods" do

    let!(:user1) do
       User.create!({username: "billybob", password: "hotdog"})
    end

    it "reset_session_token assigns new session token" do
      session_token = user1.session_token
      new_token = user1.reset_session_token!
      expect(new_token).not_to be_nil
      expect(session_token).not_to eq(new_token)
    end

    it "is_password? returns true for correct password" do
      expect(user1.is_password?("hotdog")).to be_true
    end

    it "is_password? returns false for incorrect password" do
      expect(user1.is_password?("hamburger")).to be_false
    end

    it "find_by_credentials retrieves correct user" do
      expect(User.find_by_credentials("billybob", "hotdog")).not_to be_nil
      # expect(something).to_to instance_of(User)
    end

    it "find_by_credentials does not retrieve incorrect user" do
      expect(User.find_by_credentials("billybob", "hamburger")).to be_nil
    end

  end

end
