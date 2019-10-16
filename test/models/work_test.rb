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
  
  describe "top_works_sorted_by_category" do  
    it "returns the list of 10 or less top works sorted by number of votes" do
      categories = ["book", "movie", "album"]
      categories.each do |category|
        top_works = Work.top_works_sorted_by_category(category)
        assert(top_works.length <= 10)
        
        (top_works.length - 2).times do |index|
          first_work_total_votes = top_works[index].votes.length
          second_work_total_votes = top_works[index + 1].votes.length
          assert(first_work_total_votes >= second_work_total_votes)
        end
      end
    end
    it "return empty array if there's no works" do
      Work.destroy_all
      expect (Work.count).must_equal 0
      categories = ["book", "movie", "album"]
      categories.each do |category|
        expect(Work.top_works_sorted_by_category(category)).must_equal []
      end
    end
  end
  
  describe "highest_rated_work" do  
    #Please don't forget to write test when Vote is all set up
  end
end
