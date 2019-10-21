require "test_helper"

describe User do
  describe "validations" do
    it "can be valid" do
      is_valid = users(:user1).valid?
      assert(is_valid)
    end

    it "is invalid if there is no username" do
      user = users(:user1)
      user.username = nil
      is_valid = user.valid?
      refute(is_valid)
    end
  end

  describe "relationships" do
    it 'can set the vote through "votes"' do
      Vote.destroy_all
      vote = Vote.new(work: works(:list_work_1))
      user = users(:user1)
      user.votes = [vote]

      expect(user.votes.first).must_equal vote
    end
  end
end
