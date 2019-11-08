require "test_helper"

describe UsersController do
  
  describe "current" do 
    it "responds with not_found when user hasn't logged in" do
      get current_user_path
      
      must_respond_with :not_found
    end
    
  end
end