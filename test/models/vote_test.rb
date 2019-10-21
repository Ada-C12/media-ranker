require "test_helper"

describe Vote do
  describe "relationships" do 
    it "has a user" do
      vote = Vote.first
      vote.must_respond_to :user
      vote.user.must_be_kind_of User
    end
    
    it "has a work" do
      vote = Vote.first
      vote.must_respond_to :work
      vote.work.must_be_kind_of Work
    end
  end
end
