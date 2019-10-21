require "test_helper"

describe Work do
  describe "instantiation" do
    it "can be instantiated" do
      new_work = Work.new(
        category: "book", 
        title: "New Book", 
        creator: "New Book Author",
        publication_year: 2019, 
        description: "This is a description."
      )
      expect(new_work.valid?).must_equal true
    end
    
    it "will have the required fields" do
      work = Work.first
      [:category, :title, :creator, :publication_year, :description].each do |field|
        expect(work).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      work = Work.first
      
      expect(work.votes.count).must_be :>=, 0
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
  
  describe "validations" do
    before do
      @work = Work.first
    end
    
    it "must have a category" do
      @work.category = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
      expect(@work.errors.messages[:category]).must_equal ["can't be blank"]
    end
    
    it "must have a title" do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
      expect(@work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "must have a creator" do
      @work.creator = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator
      expect(@work.errors.messages[:creator]).must_equal ["can't be blank"]
    end
    
    it "must have a publication year" do
      @work.publication_year = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year
      expect(@work.errors.messages[:publication_year]).must_equal ["can't be blank", "is not a number"]
    end
    
    it "must have a description" do
      @work.description = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :description
      expect(@work.errors.messages[:description]).must_equal ["can't be blank"]
    end
  end
  
  describe "custom methods" do
    describe "all albums" do
      it "can get all albums" do
        @albums = Work.all_albums
        expect(@albums).must_be_instance_of Array
        expect(@albums[0]).must_be_instance_of Work
        expect(@albums.length).must_equal 4
      end
    end
    
    describe "all movies" do
      it "can get all movies" do
        @movies = Work.all_movies
        expect(@movies).must_be_instance_of Array
        expect(@movies[0]).must_be_instance_of Work
        expect(@movies.length).must_equal 4
      end
    end
    
    describe "all books" do
      it "can get all books" do
        @books = Work.all_books
        expect(@books).must_be_instance_of Array
        expect(@books[0]).must_be_instance_of Work
        expect(@books.length).must_equal 5
      end
    end
    
    describe "top_10" do
      it "can return the top 10 voted works" do
        @top_10 = Work.top_10
        expect(@top_10).must_be_instance_of Array
        expect(@top_10[0]).must_be_instance_of Work
        expect(@top_10[0].title).must_equal "Movie One"
        expect(@top_10[1].title).must_equal "Album Two"
        expect(@top_10[2].title).must_equal "Book Two"
        expect(@top_10[3].title).must_equal "Album One"
        expect(@top_10[4].title).must_equal "Book Four"
        expect(@top_10[9].title).must_equal "Album Three"
        expect(@top_10[5].title).must_equal "Movie Two"
        expect(@top_10[6].title).must_equal "Book One"
        expect(@top_10[7].title).must_equal "Book Three"
        
      end
    end
    
    describe "top_1" do
      it "can return the top voted work" do
        @top_1 = Work.top_1
        expect(@top_1).must_be_instance_of Work
        expect(@top_1.title).must_equal "Movie One"
      end
    end
  end
end