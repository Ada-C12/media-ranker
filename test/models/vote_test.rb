require "test_helper"

describe Vote do
  describe "validations" do
    it "can be valid" do
      is_valid = votes(:vote1).valid?
      assert(is_valid)
    end

    it "is invalid if there is no user" do
      vote = votes(:vote1)
      vote.user = nil
      is_valid = vote.valid?
      refute(is_valid)
    end

    it "is invalid if there is no work" do
      vote = votes(:vote1)
      vote.work = nil
      is_valid = vote.valid?
      refute(is_valid)
    end

    it "is invalid if a vote has the same user and work with an existed vote" do 
      vote = votes(:vote1)
      same_vote = Vote.create(user: vote.user, work: vote.work)
      is_valid = same_vote.valid?
      refute(is_valid)
    end
  end

  describe "relationships" do
    describe "belongs to work" do
      it "can set the work_id through work" do
        user = users(:user1)
        work = works(:list_work_4)
        vote = Vote.new(user: user)
        vote.work = work

        expect(vote.work_id).must_equal work.id
      end

      it "can set the work through work_id" do
        user = users(:user1)
        work = works(:list_work_4)
        vote = Vote.new(user: user)
        vote.work_id = work.id

        expect(vote.work).must_equal work
      end
    end

    describe "belongs to user" do
      it "can set the user_id through user" do
        user = users(:user1)
        work = works(:list_work_4)
        vote = Vote.new(work: work)
        vote.user = user

        expect(vote.user_id).must_equal user.id
      end

      it "can set the work through work_id" do
        user = users(:user1)
        work = works(:list_work_4)
        vote = Vote.new(work: work)
        vote.user_id = user.id

        expect(vote.user).must_equal user
      end
    end
  end
end
