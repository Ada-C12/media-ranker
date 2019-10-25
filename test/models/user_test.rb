require "test_helper"

describe User do
  #one user has many votes
  let (:user) {users(:one)}
  
  describe "validations" do
    it "will be valid" do
      expect(user.valid?).must_equal true
    end
    
    it "will not be valid if no username is provided" do
      user.username = nil 
      expect(user.save).must_equal false
    end
  end
  
  it "will not be valid with a non-unique username" do
    #arrange
    new_user = User.new(username: user.username )
    expect(new_user.save).must_equal false
  end
  
  
  
  
end#end of user do
