require "test_helper"

describe Vote do
  describe "validations" do
    
    it "can be valid" do
      # valid_vote = votes(:valid_vote)
      valid_vote = Vote.create(user_id: users(:valid_user).id, work_id: works(:valid_work).id)
      is_valid = valid_vote.valid?
      
      assert(is_valid)
    end
    
    it "is invalid if the same user tries to vote for the same piece of work more than once" do
      valid_vote = Vote.create(user_id: users(:valid_user).id, work_id: works(:valid_work).id)
      invalid_vote = Vote.create(user_id: users(:valid_user).id, work_id: works(:valid_work).id)
      is_valid = invalid_vote.valid?
      refute(is_valid)
    end
    
  end
  
  describe "relationships" do
    it "belongs to a user and a piece of work" do
      valid_vote = Vote.create(user: users(:valid_user), work: works(:valid_work))
      expect(valid_vote.user_id).must_equal users(:valid_user).id
      expect(valid_vote.user).must_be_instance_of User
      expect(valid_vote.work_id).must_equal works(:valid_work).id
      expect(valid_vote.work).must_be_instance_of Work
    end
  end
end
