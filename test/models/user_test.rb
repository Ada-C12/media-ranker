require "test_helper"

describe User do

  describe "validations" do
    it "can be valid" do
      is_valid = users(:valid_user).valid?

      assert( is_valid)
    end
  end

  describe "relationships" do
    it "can have many votes" do
    end
  end
end
