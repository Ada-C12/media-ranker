require "test_helper"

describe Work do
  before do
    @album = works(:lux_prima)
    @movie = works(:pans_labyrinth)
    @book = works(:turn)
  end
  describe "validations" do
    it "can be valid" do
      works = [@album, @movie, @book]

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

  # custom method tests
    #top-10/spotlight
end
