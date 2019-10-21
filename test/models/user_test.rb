require "test_helper"

describe User do
  before do
    @new_user = users(:user1)
  end
  it "can be instantiated" do
    # Assert
    expect(@new_user.valid?).must_equal true
  end
  
  it "will have the required field" do
    # Arrange
    @new_user.save
    user = User.first
    expect(user).must_respond_to :name
  end
  
  describe "validations" do
    it "must have a name" do
      # Arrange
      @new_user.name = nil
      
      # Assert
      expect(@new_user.valid?).must_equal false
      expect(@new_user.errors.messages).must_include :name
      expect(@new_user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end
  
  describe "relationships" do
    
    it "can have many votes" do
      vote = votes(:vote1)
      @new_user.votes << vote
      vote = votes(:vote4)
      @new_user.votes << vote
      
      @new_user.votes.each do |vote|
        expect(vote).must_be_kind_of Vote
        
      end
    end
    
  end
  
end
