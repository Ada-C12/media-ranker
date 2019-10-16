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

      it "returns an empty array if there are no works" do
        Work.destroy_all

        top_books = Work.top_ten("book")

        expect(top_books).must_equal []
      end
    end

    describe "top media method" do
      it "returns the overall top media" do
        top_media = Work.top_media
        most_votes = Work.all.max_by { |work| work.votes.count }
        expect(top_media).must_equal most_votes
      end

      it "will return nil if there are no works" do
        Work.destroy_all

        expect(Work.top_media).must_be_nil
      end
    end
  end
end
