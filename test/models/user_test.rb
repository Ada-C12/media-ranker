require "test_helper"

describe User do
  describe "validations" do
    it "validates that there is a username" do
      result = users(:test).valid?

      expect(result).must_equal true
    end

    it "is invalid if there is no username" do
      users(:test).username = nil

      result = users(:test).valid?

      expect(result).must_equal false
    end
  end

  describe "relationships" do
    it "has a zero to many relationship with votes" do
      users(:test).save
      user = User.first

      expect(user.votes.count).must_be :>=, 0
    end
  end
end
