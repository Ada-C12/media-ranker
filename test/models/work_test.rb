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

  describe "custom methods" do
    it "can give back top ten of a media category" do
      # Act/Arrange
      top_ten = Work.top_ten("book")

      # Assert
      expect(top_ten.count).must_equal 10
  
    end
    
    it "can give the most voted media aka spotlight" do
      # Act/Arrange
      most_votes = Work.spotlight

      # Assert
      expect(most_votes.valid?).must_equal true

    end


  end
end
