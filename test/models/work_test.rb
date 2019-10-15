require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "album", title: "Lemonade", creator: "Beyonce", publication_year: 2016, description: "Sixth studio album")
  }
  describe "validations" do
    it "is valid when all fields are present" do
      result = new_work.valid?

      expect(result).must_equal true
    end

    it "is invalid when work has no title" do
      new_work.title = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
    end

    it "is invalid if the title is not unique" do
      new_work.title = works(:monae).title

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
    end
  end

  describe "relationships" do
    it "has a zero to many relationship with votes" do
      new_work.save
      work = Work.first

      expect(work.votes.count).must_be :>=, 0
    end
  end

  describe "custom methods" do
    describe "top ten method" do
      it "will return the top ten works for each media" do
        top_albums = Work.top_ten("album")
        expect(top_albums.count).must_equal 10
      end

      it "will return a list of all works if there are less than 10" do
        top_books = Work.top_ten("book")
        expect(top_books.count).wont_be_nil
      end
    end
  end
end
