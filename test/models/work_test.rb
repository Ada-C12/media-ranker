require "test_helper"

describe Work do
  describe "self.works_sorted_by_category" do
    it "returns list of objects of the same category" do 
      categories = ["book", "movie", "album"]
      categories.each do |category|
        expected_works = Work.where(category: category)
        
        existing_works = Work.works_sorted_by_category(category)
        
        expect(existing_works.length).must_equal expected_works.length
        expect(existing_works.sample.category).must_equal expected_works.sample.category
      end
    end
    
    it "returns empty array if there's no object of provided category found" do
      Work.destroy_all
      expect(Work.count).must_equal 0
      categories = ["book", "movie", "album"]
      categories.each do |category|
        expect(Work.works_sorted_by_category(category)).must_equal []
      end
    end
  end
  
  describe "top_works" do  
    it "returns the list of 10 or less top works sorted by number of votes" do
      categories = ["book", "movie", "album"]
      categories.each do |category|
        top_works = Work.top_works(category)
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
        expect(Work.top_works(category)).must_equal []
      end
    end
  end
  
  describe "highest_rated_work" do  
    #Please don't forget to write test when Vote is all set up
  end
end
