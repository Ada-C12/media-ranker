require "test_helper"

describe Vote do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe "validations" do
    it "allows a valid vote" do
      work = Work.first
      user = User.first
      
      vote = Vote.create(user_id: user.id, work_id: work.id)
      is_valid = vote.valid?
      
      assert(is_valid)
    end
    
    it "does not allow a duplicate vote" do
      work = Work.first
      user = User.first
      vote = Vote.create(user_id: user.id, work_id: work.id)
      work.reload
      
      vote = Vote.create(user_id: user.id, work_id: work.id)
      is_valid = vote.valid?
      
      refute(is_valid)
      
    end
    
    it "does not create a vote without a logged in user" do
      work = Work.first
      vote = Vote.create(user_id: nil, work_id: work.id)
      is_valid = vote.valid?
      
      refute(is_valid)
    end
    
    it "redirects the user with an error message if they try to vote without being logged in" do
      work = Work.first
      Vote.create(user_id: nil, work_id: work.id)
      must_respond_with :redirect
      
      expect(flash.any?).must_equal true
    end
  end
end
