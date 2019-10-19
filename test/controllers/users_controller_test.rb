require "test_helper"
require 'pry'

describe UsersController do
  
  let (:yml) { let_yml_superhash }
  let (:user1) { yml[:user1] }
  let (:user1_params) { { user: { name: user1.name } } }
  let (:new_user_params) { { user: { name: "Smithers" } } }
  let (:ctrller) { UsersController.new }
  
  describe "INDEX" do
    describe "As a logged in user" do
      it "can get to users index page, and has expected session" do 
        get users_path
        must_respond_with :success
        assert()
      end
    end
    
    describe "NOT as a logged in user" do
      it "can get to users index page, and has expected session" do 
        get users_path
        must_respond_with :success
        assert(session[:user_id] == nil)
      end
    end
  end
  
  describe "LOGIN" do
    it "Can send user to login page" do
      get login_path
      must_respond_with :success
    end
    
  end
  
  describe "CREATE" do
    it "Can log in existing user, show flash, and update session[:user_id]" do
      login(user1)
      # post users_path, params: user1_params
      must_redirect_to user_path(id: user1.id)
      assert(flash[:success] == "Welcome back, #{user1.name}" )
      assert(session[:user_id] == user1.id)
      
    end
    
    it "Can create and log in new user, show flash, and update session[:user_id]" do
      
      post users_path, params: new_user_params
      smithers = User.find_by(name: "Smithers")
      must_redirect_to user_path(id: smithers.id)
      assert(flash[:success] == "Successfully logged Smithers in as a new user!" )
      assert(session[:user_id] == smithers.id)
      
    end
    
    it "Logging invalid user results in render and a flash[:error]" do
      post users_path, params:  { user:{name: nil}} 
      must_respond_with :success
      assert(flash[:error].include? "Login unsuccessful! [\"Name can't be blank\"]")
    end    
    
  end
  
  describe "SHOW" do
    
    it "Can show existing user's page" do
      get user_path(id: user1.id)
      must_respond_with :success
    end
    
    it "Nonexistent user gets sent back to root_path" do
      get user_path(id: -666)
      
      must_redirect_to root_path
      assert(flash[:error] == "User does not exist!")
    end
    
  end
  
  describe "LOGOUT" do
    describe "Logging out as a valid user..." do
      it "will update session, and  flash msg when sent to root path" do
        user1
        post users_path, params: user1_params 
        assert(session[:user_id] == user1.id)
        
        patch logout_path
        assert(session[:user_id] == nil)
        assert(flash[:success] == "Successfully logged out #{user1.name}" )
        must_redirect_to root_path
      end
    end
    
    describe "Logging out as a bogus user (impossible via normal site clicks)..." do
      it "will flash msg when sent to nope_path" do
        puts "???"
        get root_path
        assert(session[:user_id] == nil)
        puts "!!!"
      end
    end
  end
  
end
