require "test_helper"

describe Work do
  before do
    @album = works(:lux_prima)
    @movie = works(:pans_labyrinth)
    @book = works(:turn)
  end
  describe "validations" do
    it "can be valid" do
      works = Work.all

      works.each do |work|
        assert(work.valid?)
      end
    end

    it "can be valid if two works have the same title and different categories" do
      movie = @movie
      pans_album = Work.new(title: "Pan's Labyrinth", category: "album")

      assert(pans_album.valid?)
    end

    it "is invalid if there is no title" do
      work = Work.first

      work.title = ""

      refute(work.valid?)
    end

    it "is invalid if there is not a category" do
      book = @book

      book.category = ""

      refute(book.valid?)
    end

    it "is invalid if the category is not 'book', 'album', or 'movie'" do
      album = @album
      invalid_category = "song"
      album.category = invalid_category

      refute(album.valid?)
    end

    it "is invalid if the title is not unique, given the category" do
      book = @book
      book_2 = Work.new(title: "The Turn of the Screw", category: "book")

      refute(book_2.valid?)
    end
  end

  describe "relationships" do
    it "can have many votes" do
      work = works(:pans_labyrinth)
      user_1 = User.first
      user_2 = User.last

      pans_vote_1 = Vote.create(user: user_1, work: work)
      pans_vote_2 = Vote.create(user: user_2, work: work)

      expect(work.votes.count).must_be :>=, 0
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end

    end
  end

  describe "spotlight" do
    it "returns the work with the most votes" do
      highest_votes = works(:pans_labyrinth)
      
      spotlight = Work.spotlight

      expect(spotlight).must_equal highest_votes
    end

    it "returns nil if no works exist" do
      Work.destroy_all

      expect(Work.spotlight).must_be_nil
    end
  end

  describe "top_ten" do
    it "returns an array of works for a specific category in order of the number of votes they have" do
      highest_votes_albums = works(:lux_prima)
      least_votes_albums = works(:album_8)

      top_ten_albums = Work.top_ten("album")

      expect(top_ten_albums).must_be_instance_of Array
      expect(top_ten_albums.length).must_equal 10
      expect(top_ten_albums.first).must_equal highest_votes_albums
      expect(top_ten_albums).wont_include least_votes_albums
    end

    it "returns a partial list of works if less than 10 works in a category exist" do
      books = Work.where(category: "book")
      book_count = books.length
      expect(book_count).must_be :<, 10

      top_ten_books = Work.top_ten("book")

      expect(top_ten_books.length).must_equal book_count
    end

    it "returns an empty array if no works for that category exist" do
      Work.destroy_all
      category = "album"

      expect(Work.top_ten(category)).must_equal []
    end
  end
end
