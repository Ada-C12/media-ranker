require "test_helper"
require "pry"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  let (:new_work) {
    Work.new(category: "Book", title: "The Fantastic Four", creator: "Wallace Rubenstein", publication_year: "2000", description: "Disgrace")
  }

  describe "validations" do
    it "must have a category" do
      #Arrange
      new_work.category = nil
      
      #Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      # binding.pry
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    
    end 
  end

    it "must have a title" do
      #Arrange
      new_work.title = nil

      #Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  
end
