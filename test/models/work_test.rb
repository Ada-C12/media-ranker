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
      it "should display the 10 elements if there 10 or more works listed" do
        movies = Work.top_ten("movie")

        expect(movies.length).must_equal 10
      end
      
      it "should display all works if there are less than 10 pieces of work" do
      end
    end
    
    describe "spotlight" do
      it "should display one piece of work" do

      end
    end
  end
end
