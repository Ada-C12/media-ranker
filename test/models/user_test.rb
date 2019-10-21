require "test_helper"

describe User do

  describe "validations" do
    it "can be valid" do
      is_valid = users(:valid_user).valid?

      assert(is_valid)
    end

    it "is invalid if there is no username" do
      is_valid = users(:invalid_user).valid?

      expect(is_valid).must_equal false
    end
  end

  describe "relationships" do
    it "can have many votes" do
      user = users(:valid_user)
      vote = votes(:vote_one)
      
      expect(user.votes.length).must_be :>=, 0
    end
  end
end
