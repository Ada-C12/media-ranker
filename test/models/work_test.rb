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
      work = Work.find_by(title: "Green Eggs and Ham")
      # Act
      
      # Assert
      
    end
    
    it "invalidates a work with no title" do
      # Arrange
      # Act
      # Assert
    end
    
    it "invalidates a work whose title is not unique within the scope of the category" do
      # Arrange
      # Act
      # Assert
    end
  end
  
  describe "custom methods" do
    it "can get the top ten works by vote" do
      # Arrange
      # Act
      # Assert
    end
    
    it "retrieves fewer than ten works if fewer than ten are in the category" do
      # Arrange
      # Act
      # Assert
    end
  end
  
end
