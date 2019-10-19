require "test_helper"

describe Vote do
  describe "validations" do
    it "can be valid" do
      votes = Vote.all

      votes.each do |vote|
        assert(vote.valid?)
      end
    end

    it "is invalid if a user tries to vote for the same work twice" do
      vote = votes(:vote_1)
      user = vote.user
      work = vote.work

      new_vote = Vote.new(user: user, work: work)

      refute(new_vote.valid?)
    end

    it "is invalid if it does not have a user" do
      work = works(:turn)

      new_vote = Vote.new(work: work)

      refute(new_vote.valid?)
    end


    it "is invalid if it does not have a work" do
      user = users(:tacocat)

      new_vote = Vote.new(user: user)

      refute(new_vote.valid?)
    end
  end

  describe "relationships" do
    it "can have one user and one work" do
      vote = Vote.last

      expect(vote.user).must_be_instance_of User
      expect(vote.work).must_be_instance_of Work
    end
  end
end
