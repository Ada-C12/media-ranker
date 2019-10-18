require "test_helper"

describe UsersController do
  describe "index" do
    it "can get the index path for users" do
      get users_path

      must_respond_with :success
    end

    it "can get the root path" do
      get root_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid user" do
      get user_path(users(:dog).id)

      must_respond_with :success
    end

    it "will be a 404 status code for an invalid user" do
      get user_path(-1)

      must_respond_with :not_found
    end
  end
  describe "login form" do
    it "can get the login form" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "logs in a returning user" do
      perform_login

      post login_path(@login_data)

      expect(session[:user_id]).must_equal @user.id
    end

    it "creates a new user when logging in if the user doesn't already exist" do
      user_data = {
        user: {
          username: "A new user",
        },
      }

      post login_path(params: user_data)
      must_respond_with :redirect
      must_redirect_to root_path

      user = User.last
      expect(session[:user_id]).must_equal user.id
    end
  end

  describe "logout" do
    it "logs a user out if logged in" do
      perform_login

      post logout_path

      expect(session[:user_id]).must_be_nil
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
