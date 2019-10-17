require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(category: "book", title: "test book", creator: "test person", publication_year: 2009, description: "test description")
    end
    
    it 'is valid when all valid fields are present' do
      expect(@work.valid?).must_equal true
    end
    
    it 'is invalid without a category' do
      @work.category = nil
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end
    
    it 'is invalid with an invalid category' do
      @work.category = "egg"
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end
    
    it 'is valid with either album, book, or movie as its category' do
      @work.category = "book"
      
      expect(@work.valid?).must_equal true
      
      @work.category = "album"
      
      expect(@work.valid?).must_equal true
      
      @work.category = "movie"
      
      expect(@work.valid?).must_equal true
    end
    
    it 'is invalid without a title' do
      @work.title = nil
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
    
    it 'is invalid if the title is not unique' do
      @work.title = works(:heart).title
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
    
    it 'is invalid without a creator' do
      @work.creator = nil
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator
    end
    
    it 'is invalid without a proper publication_year' do
      @work.publication_year = nil
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year
      
      @work.publication_year = "not a year"
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year
      
      @work.publication_year = 0
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year
    end
    
    it 'is invalid without a description' do
      @work.description = nil
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :description
    end
    
  end
  
  describe 'relations' do
    
  end
  
  describe 'custom methods' do
    describe 'top_ten' do
      it 'returns the top_ten for the category passed in' do
        top_ten_books = Work.top_ten("book")
        
        expect(top_ten_books.length).must_equal 10
      end
      
      it 'returns all the entries of the category if there are not 10' do
        top_ten_albums = Work.top_ten("album")
        
        expect(top_ten_albums.length).must_equal 2
      end
      
      it 'returns nothing if there are no entries in the category' do
        top_ten_movies = Work.top_ten("movie")
        
        expect(top_ten_movies.length).must_equal 0
      end
      
      it 'will return nothing if an invalid category is passed' do
        top_ten_blah = Work.top_ten("blah")
        
        expect(top_ten_blah.length).must_equal 0
      end
      
      it 'will return the top ten sorted by votes' do
        
      end
      
    end
  end
  
end
