require "test_helper"

describe UsersController do
  describe "login form" do
    it "can get the login form" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    # write tests for an existing user, new user, and nonexistent user
  end
end
