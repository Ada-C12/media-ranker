require "test_helper"

describe User do
  describe "relationships" do
    it "has a list of votes" do
      user = User.first
      user.must_respond_to :votes
      user.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end
    
  end
end
