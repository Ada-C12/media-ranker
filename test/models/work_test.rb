require "test_helper"

describe Work do
  
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
    
    it "can be valid" do
      is_valid = works(:work1).valid?
      
      assert( is_valid )
    end

    it "gives an error if there is no title" do
      is_invalid = works(:work1)
      is_invalid.title = nil
      
      # Assert
      expect(is_invalid.valid?).must_equal false
      expect(is_invalid.errors.messages).must_include :title
      expect(is_invalid.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end
  
  describe "custom methods" do
    
    it "can sort a category" do
      vote_sort = Work.sort_by_category("book")
      max_vote = vote_sort.first.votes.count
      min_vote = vote_sort.last.votes.count

      expect(max_vote).must_equal 4
      expect(min_vote).must_equal 0
      
    end
    
    it "can give back top ten of a media category" do
      # Act/Arrange
      top_ten = Work.top_ten("book")
      max_vote_title = top_ten.first.title


      # Assert
      expect(top_ten.count).must_equal 10
      expect(max_vote_title).must_equal "Hounds of Baskerville"
      
    end

    it "can give the most voted media aka spotlight" do
      # Act/Arrange
      most_votes = Work.spotlight
      spotlight_title = most_votes.title
      # Assert
      expect(most_votes.votes.count).must_equal 5
      expect(spotlight_title).must_equal "A Night at the Opera"
    end
    
    
  end
end
