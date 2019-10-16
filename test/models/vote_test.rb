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

    it "is invalid if it does not have a valid user" do
    end


    it "is invalid if it does not have a valid work" do

    end
  end

  describe "relationships" do
    it "can have one user and one work" do
      vote = Vote.last

      expect(vote.user).must_be_instance_of User
      expect(vote.work).must_be_instance_of Work
    end
  end

  #custom validations
end
