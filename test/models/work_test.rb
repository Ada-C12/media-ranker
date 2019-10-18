require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe "validations" do
    it "correctly validates a work with a unique title" do
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
      spotlight = Work.spotlight
      # Act
      # Assert
      expect(top_ten.length).must_equal 10
      expect(top_ten.first.id).must_equal spotlight.id
    end
    
    it "retrieves fewer than ten works if fewer than ten are in the category" do
      # Arrange
      top_works = Work.top_ten("album")
      # Act
      # Assert
      expect(top_works.length).must_equal Work.where(category: "album").length
      expect(top_works.first.id).must_equal Work.where(category: "album").first.id
      
    end
    
    it "can get the work with the highest vote" do
      work = Work.last
      user = User.first
      vote = Vote.create(user_id: user.id, work_id: work.id)
      work.reload
      
      spotlight = Work.spotlight
      
      expect(spotlight).must_be_instance_of Work
      expect(spotlight.votes.length).must_equal work.votes.length      
    end
    
  end
  
end
