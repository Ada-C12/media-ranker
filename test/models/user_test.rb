require "test_helper"

describe User do
  let(:valid_user) {
    User.create(username: "Some Valid Name")
  }
  describe "validations" do
    it "can be valid" do
      is_valid = valid_user.valid?

      assert( is_valid )
    end

    it "is invalid if there is no username" do
      invalid_user_without_title = User.create(username: "")

      is_valid = invalid_user_without_title.valid?

      refute( is_valid )
    end
  end
end
