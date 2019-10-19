require "test_helper"

describe User do
  
  it "can be instantiated" do
    is_valid = users(:user1).valid?
    
    assert( is_valid )
    
  end
  
  it "will have the required fields" do
    valid_user = users.first
    [:username].each do |field|
      
      expect(valid_user).must_respond_to field
    end
  end
  
  describe "validations" do
    it "must have a username" do
      is_invalid = users(:user1)
      is_invalid.username = nil
      
      # Assert
      expect(is_invalid.valid?).must_equal false
      expect(is_invalid.errors.messages).must_include :username
      expect(is_invalid.errors.messages[:username]).must_equal ["can't be blank"]
      
    end
  end
end
