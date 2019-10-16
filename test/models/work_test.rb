require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(category: "movie", title: "A River Runs Through It", creator: "Robert Redford", publication_year: 1991, description: "Fly fishing in Montana")
    end
    
    it 'is valid when all fields are present' do
      expect(@work.valid?).must_equal true
    end
    
    it 'is valid if the title is not unique but is a different category' do
      @work.title = works(:blue).title
      
      expect(@work.valid?).must_equal true
    end
    
    it 'is invalid without a title' do
      @work.title = nil
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
    
    it 'is invalid if the title is not unique within the same category' do
      @work.title = works(:rocky).title
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end
end
