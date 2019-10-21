require "test_helper"

describe UsersController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe "login" do
    it "can successfully login a new user" do
      user = User.create(username: "Don Cheadle")
      login_data = {
        user: {
          username: user.username
        }
      }
      
      post login_path(login_data)
      
      expect(session[:user_id]).must_equal user.id      
      must_redirect_to root_path
    end
    it "can successfully login a returning user" do
      user = User.first
      login_data = {
        user: {
          username: user.username
        }
      }
      
      expect{ post login_path(login_data) }.must_differ "User.count", 0
      
      expect(session[:user_id]).must_equal user.id
      must_redirect_to root_path
    end
    it "does not login a user without a username" do
      login_data = {
        user: {
          username: ""
        }
      }
      post login_path(login_data)
      expect(session[:user_id]).must_equal nil
    end
  end
end
