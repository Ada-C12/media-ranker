require "test_helper"

describe Vote do
  describe "relationships" do
    it "can set user through 'user'" do
      user = users(:user1)
      votes(:vote1).user = user
      
      expect(votes(:vote1).user).must_equal user  
    end
    
    it "can set work through 'work'" do
      work = works(:work1)
      votes(:vote1).work = work
      
      expect(votes(:vote1).work).must_equal work
    end
  end
  
  describe "validations" do
    
    it "can be valid" do
      is_valid = votes(:vote1).valid?
      
      assert(is_valid)
    end
    
    it "must have a work and user, otherwise it is invalid" do
      is_invalid = votes(:vote1)
      is_invalid.work = nil

      refute(is_invalid.valid?)
    end
    
    it "gives an error if user voted for same work more than once" do
      is_invalid = Vote.create(work: works(:work2), user: users(:user1))
      
      refute(is_invalid.valid?)
      expect(is_invalid.errors.messages).must_include :work
      expect(is_invalid.errors.messages[:work]).must_equal ["user has already voted for this work"]
      
    end
  end
end
