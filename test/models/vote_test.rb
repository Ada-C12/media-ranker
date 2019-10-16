require "test_helper"

describe Vote do
  before do
    @new_vote = votes(:vote1)
  end
  it "can be instantiated" do
    # Assert
    expect(@new_vote.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    @new_vote.save
    vote = Vote.first
    [:user, :work].each do |field|
      
      # Assert
      expect(vote).must_respond_to field
    end
  end
  
  describe "validations" do
    it "must have a work" do
      # Arrange
      @new_vote.work = nil
      
      # Assert
      expect(@new_vote.valid?).must_equal false
      expect(@new_vote.errors.messages).must_include :work
      expect(@new_vote.errors.messages[:work]).must_equal ["must exist"]
    end
    
    it "must have a user" do
      # Arrange
      @new_vote.user = nil
    
      # Assert
      expect(@new_vote.valid?).must_equal false
      expect(@new_vote.errors.messages).must_include :user
      expect(@new_vote.errors.messages[:user]).must_equal ["must exist"]
    end

    it "is invalid if the work is not unique for a given user" do
      vote = votes(:vote2)
      vote.user = users(:user1)
      
      expect(vote.valid?).must_equal false
      
    end
  end

  describe "relationships" do

    it "has a user that is an instance of User" do
      expect(@new_vote.user).must_be_kind_of User
    end

    it "has a work that is an instance of Work" do
      expect(@new_vote.work).must_be_kind_of Work
    end

  end
end
