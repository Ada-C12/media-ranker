require "test_helper"

describe UsersController do
  
  describe "fixtures" do
  end
  
  describe "index" do
    it "index lists all users, responds with success" do
      get users_path 
      must_respond_with :success
      assert_equal 8, User.count
    end
    
    it "index is empty if no instances of user exist, still responds with success" do
      User.destroy_all
      get users_path 
      must_respond_with :success
      assert_equal 0, User.count
    end
  end
  
  describe "new" do
    it "responds with success because a new user can be created" do
      get new_user_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "creating a new user increases the total number of users, responds with success" do
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
      get user_path(-5)
      must_respond_with :not_found
    end
    
  end
  
  describe "login" do
    # I am refusing to write tests for this atm. 
  end
  
  describe "logout" do
    # I am refusing to write tests for this atm. 
  end
  
end
