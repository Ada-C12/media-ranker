require "test_helper"

describe User do
  describe "relations" do
    it "should have a relation between a user and a vote" do
      

    end
  end

  describe "validations" do
    let(:non_user) {User.new(username: "")}
    
    it "should have a username" do
      user_one = users(:user_one)
      expect(user_one).must_be :valid?
    end

    it "should have a unique username" do
      expect(non_user).must_be :invalid?
    end
  end
end
 
