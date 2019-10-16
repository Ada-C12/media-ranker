require "test_helper"

describe Work do
  describe "self.works_by_category" do
    it "returns list of objects of the same category" do 
      expected_movies = Work.where(category: "movie")
      expected_books = Work.where(category: "book")
      expected_albums = Work.where(category: "album")

      existing_movies = Work.works_by_category("movie")
      existing_books = Work.works_by_category("book")
      existing_albums = Work.works_by_category("album")

      expect(existing_movies.length).must_equal expected_movies.length
      expect(existing_movies.sample.category).must_equal expected_movies.sample.category

      expect(existing_books.length).must_equal expected_books.length
      expect(existing_books.sample.category).must_equal expected_books.sample.category

      expect(existing_albums.length).must_equal expected_albums.length
      expect(existing_albums.sample.category).must_equal expected_albums.sample.category
    end

    it "returns empty array if there's no object of provided category found" do
      Work.destroy_all
      expect(Work.count).must_equal 0

      expect(Work.works_by_category("movie")).must_equal []
      expect(Work.works_by_category("book")).must_equal []
      expect(Work.works_by_category("album")).must_equal []
    end
  end
end
