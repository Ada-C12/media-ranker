require "test_helper"

describe Vote do
  describe "validations" do
    before do
      @vote_hash = {
        vote: {
          id: 1,
          work_id: 1,
          user_id: 1,
        },
      }
      
    end
    it "associated user_id is needed for creation of a vote" do
      vote = Vote.new(work_id: 1)
      refute(vote.valid?) 
      
    end
    
    it "associated work_id is needed for creation of a vote" do
      vote = Vote.new(user_id: 1)
      refute(vote.valid?) 
    end
    
    it "a vote cannot be duplicated" do
      vote = Vote.new(user_id: 1, work_id: 1)
      refute(vote.valid?) 
    end
    
    it "a vote can be created with a unique combination of work and user" do
      vote = Vote.new(user_id: 1, work_id: 2)
      expect{vote.save}.wont_change "Vote.count"
    end
    
    
  end
end
