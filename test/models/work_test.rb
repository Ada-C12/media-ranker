require "test_helper"

describe Work do
  before do
    @new_work = works(:book)
  end
  it "can be instantiated" do
    # Assert
    expect(@new_work.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    @new_work.save
    work = Work.first
    [:category, :title].each do |field|
      
      # Assert
      expect(work).must_respond_to field
    end
  end
  
  describe "validations" do
    it "must have a title" do
      # Arrange
      @new_work.title = nil
      
      # Assert
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :title
      expect(@new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "must have a category" do
      # Arrange
      @new_work.category = nil
      
      # Assert
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :category
      expect(@new_work.errors.messages[:category]).must_equal ["can't be blank", "is not included in the list"]
    end
    
    it "is invalid if the title is not unique for a given category" do
      @new_work.category = "album"
      @new_work.title = "test title"
      album = works(:album)
      album.title = "test title"
      
      album.save
      
      expect(@new_work.valid?).must_equal false
      
    end
    
    it "is valid if the title is unique for a given category" do
      album = works(:album)
      album.title = "test"
      @new_work.title = "test"
      
      expect(album.valid?).must_equal true
    end
  end

  describe "relationships" do

    it "can have many votes" do
      vote = votes(:vote1)
      @new_work.votes << vote
      vote = votes(:vote2)
      @new_work.votes << vote

      @new_work.votes.each do |vote|
        expect(vote).must_be_kind_of Vote

      end
    end

  end

  describe "custom methods" do
    describe "self.spotlight" do

      it "will return the work with the most votes" do

      end

      it "will return the first work in the event of a tie" do

      end

      it "will return and empty array if there are no works" do

      end

    end

    describe "self.top_ten" do

      it "will return the ten works with the most votes in that category" do

      end

      it "will return an empty array if there are no works in that category" do

      end

    end


  end
end
