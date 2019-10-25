require "test_helper"

describe Vote do
  let (:vote) {votes(:one)}
  
  describe "validations" do
    it "will have a valid user id" do
      expect(vote.user_id).wont_equal nil
    end
    
    it "will not be valid if no user id is given" do
      vote.user_id = nil 
      expect(vote.save).must_equal false
    end
    
    it "will not be valid if user_id has already voted on same work" do
      #arrange
      new_vote = Vote.new(user: vote.user)
      expect(vote.save).must_equal false
    end
    
    it "will have a valid work id" do
      expect(vote.work_id).wont_equal nil
    end
    
    
  end
end#end of vote do
