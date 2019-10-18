require "test_helper"

describe User do
  describe "validations" do
    it "does not allow the creation of a user with an empty username" do
      test_user = User.new(username: "")
      refute(test_user.valid?)
    end
    
    it "does not allow the creation of a user with a duplicate username" do
      already_used_username = User.first.username
      test_user = User.new(username: already_used_username)
      refute(test_user.valid?) 
    end
    
  end
  
end
