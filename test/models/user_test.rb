require "test_helper"

describe User do
  describe "validations" do
    it "can be valid" do
      user = users(:valid_user)

      is_valid = user.valid?

      assert(is_valid)
    end

    it "will be invalid if no username is given" do
      user = User.create(username: "")

      is_valid = user.valid?

      refute(is_valid)
    end
  end

  describe "relationships" do
    it "can have many votes" do
      user = users(:valid_user)
      work = works(:valid_work)
      work_2 = works(:valid_work_1)

      vote_1 = Vote.create(user_id: user.id, work_id: work.id)
      vote_2 = Vote.create(user_id: user.id, work_id: work_2.id)

      expect(user.votes.count).must_equal 2
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
