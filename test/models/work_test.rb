require "test_helper"

describe Work do
  describe "validations" do
    it "can be valid" do
      is_valid = works(:valid_work).valid?

      assert(is_valid)
    end

    it "is invalid if there is no title" do
      work = Work.new(category: "movie", title: "", creator: "time curry", publication_year: "1990")

      is_valid = work.valid?

      refute(is_valid)
    end

    it "is invalid if it has the same title as another work in the same category" do
      new_work = Work.new(category: "movie", title: "Clue")

      is_valid = new_work.valid?

      refute(is_valid)
    end

    it "is valid if it has the same title as another work in a different category" do
      new_book = Work.new(category:"book", title: "Clue")

      is_valid = new_book.valid?

      assert(is_valid)
    end
  end

  describe "custom methods" do
    describe "top-ten" do
      
    end
    
    describe "spotlight" do
    end
  end
end
