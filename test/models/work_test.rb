require "test_helper"

describe ApplicationHelper, :helper do
  describe 'validation' do
    before do
      @obama = works(:obama)
    end

    it "is valid when all fields are present" do
      value(@obama).must_be :valid?
    end

    it "is invalid without a title" do
      @obama.title = nil

      expect(@obama.valid?).must_equal false
    end

    it "is invalid without a creator" do
      @obama.creator = nil

      expect(@obama.valid?).must_equal false
    end

    it "is invalid without a category" do
      @obama.category = nil

      expect(@obama.valid?).must_equal false
    end

    it "is invalid without a publishing year" do
      @obama.publication_year = nil

      expect(@obama.valid?).must_equal false
    end

    it "is invalid with a publishing year greater than 1000" do
      @obama.publication_year = 1000

      expect(@obama.valid?).must_equal false
    end
  end

  describe "find_spotlight" do
    it "returns an item of media" do
      spotlight = Work.find_spotlight

      expect(spotlight).must_be_kind_of Work
    end

    it "returns nil if no media" do
      works = Work.all
      works.each do |work|
        work.destroy
      end

      expect(Work.count).must_equal 0
      expect(Work.find_spotlight).must_be_nil
    end

  end

  describe "top_ten" do
    it "returns 10 items of media when given category" do
      sample = Work.top_ten(:book)

      expect(sample.length).must_equal 10
      sample.each do |work|
        expect(work).must_be_kind_of Work
      end
    end

    it "returns nil when not given category" do
      invalid_sample = Work.top_ten(nil)

      expect(invalid_sample).must_equal nil
      
    end
  end
end
