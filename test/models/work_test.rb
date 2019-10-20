require_relative "../test_helper"

describe Work do
  describe 'validations' do 
    # Arrange
    before do 
      @user = User.create(username: "hello_world")
      @movie = Work.create(category: "movie", title: "Nightmare Before Chirstmas", creator: "Tim Burton", publication_year: 1993, description: "Jack Skellington tries to bring Christmas magic to Halloween Town. Chaos ensues.")
      @vote = Vote.create(user_id: @user.id, work_id: @movie.id)
    end
    
    #Act
    it "is valid when all fields are present" do 
      result = @movie.valid?
      
      #Assert
      expect(result).must_equal true
    end
    
    it "is invalid without a category" do 
      #Arrange
      @movie.category = nil
      
      #Act
      result = @movie.valid?
      
      #Assert
      expect(result).must_equal false
    end
    
    it "is invalid without a title" do 
      @movie.title = nil
      
      #Act
      result = @movie.valid?
      
      #Assert
      expect(result).must_equal false
    end
    
    it "is invalid without a creator" do 
      @movie.creator = nil
      
      #Act
      result = @movie.valid?
      
      #Assert
      expect(result).must_equal false
    end
    
    it "is invalid without a publication date" do 
      @movie.publication_year = nil
      
      #Act
      result = @movie.valid?
      
      #Assert
      expect(result).must_equal false
    end
    
    it "is valid when title is unique" do 
      # Arrange
      movie2 = Work.create(category: "movie", title: "Nightmare Before Chirstmas", creator: "Tim Burton", publication_year: 1993, description: "Jack Skellington tries to bring Christmas magic to Halloween Town. Chaos ensues.")
      movie3 = Work.create(category: "movie", title: "Hocus Pocus", creator: "Fox", publication_year: 1993, description: "spooky movie")
      
      #Act 
      result2 = movie2.valid? 
      result3 = movie3.valid? 
      
      #Assert
      expect(result2).must_equal false
      expect(result3).must_equal true
    end
  end
  
  describe "works category seperation" do
    before do 
      # Arrange
      movie1 = Work.create(category: "movie", title: "Lion King", creator: "Disney", publication_year: 1994, description: "hamlet with lions")
      movie2 = Work.create(category: "movie", title: "Avengers", creator: "Disney", publication_year: 2019, description: "they go back in time")
      book1 =  Work.create(category: "book", title: "POODR", creator: "Sandy Betz", publication_year: 2010, description: "required reading")
      book2 =  Work.create(category: "book", title: "something", creator: "Me", publication_year: 2019, description: "blah blah cool fun wow")
      album =  Work.create(category: "album", title: "1989", creator: "Taylor Swift", publication_year: 2015, description: "Welcome to New York")
    end
    
    it "lists only books" do 
      # Act
      books = Work.top_category("book")
      
      # Assert
      expect(books.length).must_equal 2
      expect(books.first.category).must_equal "book"
      expect(books.last.category).must_equal "book"
    end
    
    it "lists only movies" do 
      # Act
      movies = Work.top_category("movie")
      
      # Assert
      expect(movies.length).must_equal 2
      expect(movies.first.category).must_equal "movie"
      expect(movies.first.category).must_equal "movie"
    end
    
    it "lists only albums" do 
      #Act 
      albums = Work.top_category("album")
      
      #Assert
      expect(albums.length).must_equal 1
      expect(albums.first.category).must_equal "album"
    end
  end 
  
  describe "spotlight" do 
    it "features a spotlight media work" do 
      # Arrange
      user = User.create(username: "hello_world")
      movie = Work.create(category: "movie", title: "Lion King", creator: "Disney", publication_year: 1994, description: "hamlet with lions")
      book =  Work.create(category: "book", title: "POODR", creator: "Sandy Betz", publication_year: 2010, description: "required reading")
      album =  Work.create(category: "album", title: "1989", creator: "Taylor Swift", publication_year: 2015, description: "Welcome to New York")
      vote = Vote.create(work_id: album.id, user_id: user.id)
      
      # Act
      spotlight_feature = Work.spotlight
      
      # Assert
      expect(spotlight_feature).must_equal album
    end
    
    it "return nil if there is no spotlight feature" do 
      Work.destroy_all
      spotlight = Work.spotlight 

      expect(spotlight).must_be_nil
    end
  end
  
  describe "relationships" do 
    before do 
      # Arrange
      @user = User.create(username: "hello_world")
      @user2 = User.create(username: "goodmorning world!")
      @movie = Work.create(category: "movie", title: "Nightmare Before Chirstmas", creator: "Tim Burton", publication_year: 1993, description: "Jack Skellington tries to bring Christmas magic to Halloween Town. Chaos ensues.")
      @vote = Vote.create(user_id: @user.id, work_id: @movie.id)
      @vote2 = Vote.create(user_id: @user2.id, work_id: @movie.id)
    end 
    
    it "can have many votes" do 
      # Assert
      expect(@movie.votes.length).must_equal 2
      expect(@movie.votes[0]).must_be_kind_of Vote 
    end
  end
end
