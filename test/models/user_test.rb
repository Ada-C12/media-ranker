require "test_helper"

describe User do
  let(:new_user) {
    User.new(username: "test")
  }
  describe "validations" do
    it "validates that there is good data" do
      result = new_user.valid?

      expect(result).must_equal true
    end

    it "is invalid if there is no username" do
      new_user.username = nil

      result = new_user.valid?

      expect(result).must_equal false
    end
  end

  describe "relationships" do
    it "has a zero to many relationship with votes" do
      new_user.save
      user = User.first

      expect(user.votes.count).must_be :>=, 0
    end
  end
end
