require "test_helper"

describe Vote do
  describe "validations" do
    it "can be valid" do
      user = users(:valid_user)
      work = works(:valid_work)
      vote = Vote.create(user_id: user.id, work_id: work.id)

      is_valid = vote.valid?

      assert(is_valid)
    end

    it "it is invalid if a user votes on the same piece of work more than once" do
      user = users(:valid_user)
      work = works(:valid_work)
      first_vote = Vote.create(user_id: user.id, work_id: work.id)
      second_vote = Vote.create(user_id: user.id, work_id: work.id)

      is_valid = second_vote.valid?

      refute(is_valid)
    end

  end

  describe "relationships" do
    it "belongs to a user" do
      user = users(:valid_user)
      work = works(:valid_work)
      vote = Vote.create(user_id: user.id, work_id: work.id)

      expect(vote.user.valid?).must_equal true
      expect(vote.user.id).must_equal user.id
      expect(vote.user).must_be_instance_of User
    end

    it "belongs to a piece of work" do
      user = users(:valid_user)
      work = works(:valid_work)
      vote = Vote.create(user_id: user.id, work_id: work.id)

      expect(vote.work.valid?).must_equal true
      expect(vote.work.id).must_equal work.id
      expect(vote.work).must_be_instance_of Work
    end

  end

end
