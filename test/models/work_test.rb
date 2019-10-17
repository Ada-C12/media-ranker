require "test_helper"

describe Work do

  describe "validations" do

    it "can be valid" do
      is_valid = works(:work1).valid?

      assert( is_valid )

    end

    it "will respond will error if invalid data" do
      is_invalid = works(:work1)
      is_invalid.title = nil

      # Assert
      expect(is_invalid.valid?).must_equal false
      expect(is_invalid.errors.messages).must_include :title
      expect(is_invalid.errors.messages[:title]).must_equal ["can't be blank"]

    end
  end
end
