require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  
  describe Vote do
    let (:new_vote) {
    work_one = Work.new(category: "movie", title: "Mulan", creator: "disney", publication_year: 1990, description: "girl who loves books falls in love with prince")
    user_one = User.new(username: "muffin")
    
    new_vote = Vote.new(user: user_one, work: work_one)
  }
  
  describe "validations" do
    it "must have a user" do
      # Arrange
      new_vote.user = nil
      
      # Assert
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :user
      expect(new_vote.errors.messages[:user]).must_equal ["must exist", "can't be blank"]
    end
    
    it "must have a work" do
      # Arrange
      new_vote.work = nil
      
      # Assert
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work
      expect(new_vote.errors.messages[:work]).must_equal ["must exist", "can't be blank"]
    end
  end
end
end
