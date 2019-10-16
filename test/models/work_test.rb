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
end
