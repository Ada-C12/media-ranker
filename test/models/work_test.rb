require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe "validations" do
    it "correctly validates a work with a unique title" do
      Work.all.each do |work|
        p work.id
        p work.title
        p work.creator
        p work.publication_year
      end
      
      # Arrange
      work = Work.find_by(title: "Millions of Cats")
      # Act
      is_valid = work.valid?
      
      # Assert
      assert( is_valid )
    end
    
    it "invalidates a work with no title" do
      # Arrange
      work = Work.new(category: "book")
      # Act
      is_valid = work.valid?
      
      # Assert
      refute( is_valid )
      
    end
    
    it "invalidates a work whose title is not unique within the scope of the category" do
      # Arrange
      work = Work.new(category: "book", title: "Millions of Cats")
      # Act
      is_valid = work.valid?
      
      # Assert
      refute( is_valid )
    end
  end
  
  describe "custom methods" do
    it "can get the top ten works by vote" do
      # Arrange
      top_ten = Work.top_ten("book")
      
      # Act
      p top_ten
      # Assert
      expect(top_ten.length).must_equal 10
      expect(top_ten.first.id).must_equal Work.first.id
    end
    
    it "retrieves fewer than ten works if fewer than ten are in the category" do
      # Arrange
      works = Work.top_ten("movie")
      top_works = works.top_ten()
      # Act
      
      # Assert
      expect(top_ten.length).must_equal Work.all.length
      expect(top_ten.length).must_be_less_than 10
      expect(top_ten.first.id).must_equal Work.first.id
      
    end
  end
  
end
