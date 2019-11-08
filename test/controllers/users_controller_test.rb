require "test_helper"

describe UsersController do
  describe "login_form" do
    it "responds with success" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "if user exists, logs user in with flash " do
      user = User.create!(username: "blah")
      login_data = {
        user: {
          username: user.username
        }
      }

      expect{
        post "/login", params: login_data
      }.wont_change "User.count"

      expect(flash[:success]).must_equal "Successfully logged in as returning user #{user.username}"

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "if user doesn't exist, creates new user" do
      login_data = {
        user: {
          username: "new user"
        }
      }

      expect{
        post "/login", params: login_data
      }.must_change "User.count", 1

      expect(flash[:success]).must_equal "Successfully logged in as new user #{login_data[:user][:username]}"
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "current" do
    it "returns 200 OK for a logged-in user" do
      user = User.create!(username: "New")
      login_data = {
        user: {
          username: user.username
        }
      }

      post login_path, params: login_data

      expect(session[:user_id]).must_equal user.id

      get current_user_path

      must_respond_with :success
    end

    it "returns flash message if user not logged in" do
      post logout_path

      get current_user_path

      expect(flash[:error]).must_equal "You must be logged in to see this page"

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "logout" do
    it "logs user out" do

      user = User.create!(username: "New")
      login_data = {
        user: {
          username: user.username
        }
      }
      post login_path, params: login_data

      expect(session[:user_id]).must_equal user.id

      post logout_path

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
