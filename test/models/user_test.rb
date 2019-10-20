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
    before do
      users(:test).save
      @user = User.first
    end
    it "has a zero to many relationship with votes" do
      expect(@user.votes.count).must_be :>=, 0
    end

    it "can have many votes" do
      @user.votes.each do |vote|
        expect(vote).must_be_instance_of User
      end
    end
  end
end
