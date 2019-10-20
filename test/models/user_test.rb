require "test_helper"

describe User do
  
  it "will have the required fields" do
    valid_user = users.first
    [:username].each do |field|
      
      expect(valid_user).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      valid_user = users(:user2)

      expect(valid_user.votes.count).must_equal 6
      valid_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end      
    end
  end
  
  describe "validations" do
    it "can be valid" do
      is_valid = users(:user1).valid?
      
      assert( is_valid )
    end
    
    it "must have a username" do
      is_invalid = users(:user1)
      is_invalid.username = nil
      
      # Assert
      refute(is_invalid.valid?)
      expect(is_invalid.errors.messages).must_include :username
      expect(is_invalid.errors.messages[:username]).must_equal ["can't be blank"]
      
    end
  end
end
