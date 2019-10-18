require "test_helper"

describe User do
  let (:new_user) {
    User.new(
      username: "Mochi Cat"
    )
  }
  
  describe "validations" do
    it "can create a valid user" do
      expect(new_user.save).must_equal true
    end
    
    it "will have the required fields" do
      new_user.save
      user = User.last
      
      expect(user).must_respond_to :username
    end
    
    it "cannot create a user without an username" do
      new_user.username = nil
      
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      expect(users(:doug).votes.count).must_be :>, 1
      
      users(:doug).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
