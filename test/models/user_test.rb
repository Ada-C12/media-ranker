require "test_helper"

describe User do
  describe "validations" do

    it "can be valid" do
      is_valid = users(:user1).valid?

      assert( is_valid )

    end

    it "will respond will error if invalid data" do
      is_invalid = users(:user1)
      is_invalid.username = nil

      # Assert
      expect(is_invalid.valid?).must_equal false
      expect(is_invalid.errors.messages).must_include :username
      expect(is_invalid.errors.messages[:username]).must_equal ["can't be blank"]

    end
  end
end
