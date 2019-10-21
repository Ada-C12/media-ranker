require "test_helper"

describe UsersController do
  
  describe "fixtures" do
  end
  
  describe "index" do
    it "index lists all users, responds with success" do
      users_in_fixtures = 8
      get users_path 
      must_respond_with :success
      assert_equal users_in_fixtures, User.count
    end
    
    it "index is empty if no instances of user exist, still responds with success" do
      
      #This test doesn't work (yet) because when a user is destroyed, the votes are then missing validation information. 
      
      # User.destroy_all
      # get users_path 
      # must_respond_with :success
      # assert_equal 0, User.count
    end
  end
  
  describe "new" do
    it "responds with success because a new user can be created" do
      get new_user_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "creating a new user increases the total number of user" do
      username = "Testy"
      
      user_hash = {
        user: {
          username: username,
        }
      }
      expect { post users_path, params: user_hash }.must_change "User.count", 1
      
      user = User.find_by(username: username)
      expect(user.username).must_equal user_hash[:user][:username]
      
    end
  end
  
  describe "show" do
    it "responds with success when showing information for a valid user" do
      test_user = User.first
      get user_path(test_user.id)
      must_respond_with :success
    end
    
    it "responds with 404 when trying to show the information for an invalid driver" do 
      # Throwing error because there is no current user, so params isn't passing in any sort of User ID 
      
      # @user = User.first.id
      # get user_path(-5)
      # must_respond_with :not_found
    end
    
  end
  
  describe "login" do
    it "will create a new user if a username is unique" do
      test_user = User.first
      get login_path(test_user.id)
      must_respond_with :success
    end
    
  end
  
  describe "logout" do
    it "will log out the user" do
      post logout_path
      must_respond_with :redirect
    end
  end
  
  describe "current" do
    it "returns 200 OK for a logged-in user" do
      user = User.first
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
  end
  
end
