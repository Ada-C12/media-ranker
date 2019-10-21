require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  describe Work do

    describe "validations" do
      
      it "can be valid" do
        is_valid = works(:valid_work).valid?
        assert( is_valid )
      end
  
      it "is invalid if there is no category" do
        work = works(:invalid_work_without_category)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no title" do
        work = works(:invalid_work_without_title)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no creator" do
        work = works(:invalid_work_without_creator)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no publication_year" do
        work = works(:invalid_work_without_publication_year)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no description" do
        work = works(:invalid_work_without_description)
        is_valid = work.valid?
        refute( is_valid )
      end

    end

    describe "Top-Ten Method " do
      before do
      end
      it "returns 10 books with decreasig number of votes" do
        works = Work.all.sort_by_category("book")
        # print works
        expect(works.length).must_equal 2
        expect(works.first.title).must_equal "Melty Breaker"
        expect(works.last.title).must_equal "Winter Pie"
      end
      it "returns less than 10 if there are less than ten works" do
        works = Work.sort_by_category("album")
        expect(works.length).must_equal 5
        expect(works.first.title).must_equal "Blue Breaker"
      end
      it "returns an empty array if there are no works" do 
        works = Work.sort_by_category("movie")
        expect(works.length).must_equal 0
      end 
    end










  end
end
