require "test_helper"

describe User do
  describe "instantiation" do
    it "can be instantiated" do
      new_user = User.new(
        name: "Peter"
      )
      expect(new_user.valid?).must_equal true
    end
    
    it "will have the required fields" do
      user = User.first
      expect(user).must_respond_to :name
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      user = User.first
      
      expect(user.votes.count).must_be :>=, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
  
  describe "validations" do
    before do
      @user = User.first
    end
    
    it "must have a name" do
      @user.name = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name
      expect(@user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end
  
  describe "custom methods" do
    describe "all users" do
      it "can get all users" do
        @users = User.all_users
        expect(@users).must_be_instance_of Array
        expect(@users[0]).must_be_instance_of User
        expect(@users.length).must_equal 3
        # need to test the sorting here as well 
      end
    end
  end
end
