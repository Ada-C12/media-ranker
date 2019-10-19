require "test_helper"

describe Work do
  
  it "can be instantiated" do
    is_valid = works(:work1).valid?
    
    assert( is_valid )
  end
  
  it "will have the required fields" do
    valid_work = works.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      
      expect(valid_work).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      
      
    end
  end
  
  
  describe "validations" do
    it "must have a title" do
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
