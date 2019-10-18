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
    it 'can have multiple votes' do
      work = works(:heart)
      vote1 = Vote.create(work_id: work.id, user_id: users(:taro).id)
      vote2 = Vote.create(work_id: work.id, user_id: users(:mario).id)
      
      expect(work.votes.count).must_equal 2
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
    
    it 'can have no votes' do
      work = works(:heart)
      
      expect(work.votes.count).must_equal 0
    end
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
    end
    
    describe 'sort_works' do
      before do
        vote1 = Vote.create(work_id: works(:heart).id, user_id: users(:taro).id)
        vote2 = Vote.create(work_id: works(:heart).id, user_id: users(:mario).id)
      end
      
      it 'will property sort the media by votes in descending order' do
        sorted_books = Work.sort_works('book')
        
        expect(sorted_books[0].title).must_equal works(:heart).title
        expect(sorted_books[-1].title).must_equal works(:h).title
      end
    end
    
    describe 'best_work' do
      it 'will return the first media if nothing has votes' do
        expect(Work.best_work(Work.all).title).must_equal works(:heart).title
      end
      
      it 'will return the work with the most votes if there are votes' do
        vote1 = Vote.create(work_id: works(:heart).id, user_id: users(:taro).id)
        vote2 = Vote.create(work_id: works(:heart).id, user_id: users(:mario).id)
        
        expect(Work.best_work(Work.all).title).must_equal works(:heart).title
      end
      
      it 'if there is a tie it will return the last instance with the most votes' do
        vote1 = Vote.create(work_id: works(:blue).id, user_id: users(:taro).id)
        vote2 = Vote.create(work_id: works(:blue).id, user_id: users(:mario).id)
        
        expect(Work.best_work(Work.all).title).must_equal works(:blue).title
      end
    end
    
  end
  
end
