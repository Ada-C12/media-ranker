require "test_helper"

describe Work do
  let (:new_work) {
    works(:new_work)
  }
  let (:movie) {
    works(:movie)
  }
  let (:movie_two) {
    works(:movie_two)
  }
  let (:movie_three) {
    works(:movie_three)
  }
  let (:book) {
    works(:book)
  }
  let (:new_user) {
    users(:new_user)
  }
  let (:user) {
    users(:user)
  }
  let (:other_user) {
    users(:other_user)
  }
  let (:album) {
    works(:album)
  }
  let (:album_two) {
    works(:album_two)
  }
  let (:album_three) {
    works(:album_three)
  }
  let (:album_four) {
    works(:album_four)
  }
  let (:book) {
    works(:book)
  }
  let (:book_two) {
    works(:book_two)
  }
  let (:book_three) {
    works(:book_three)
  }
  let (:book_four) {
    works(:book_four)
  }
  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    [:title, :category, :publication_year, :creator, :description].each do |field|

      # Assert
      expect(new_work).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # Arrange

      expect(new_work.votes.count).must_equal 2
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a title" do

      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title

      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "self.spotlight" do
      it "returns the most upvoted work" do
        expect(Work.spotlight).must_equal album_two
      end

      it "returns a new work when it becomes the most upvoted" do
        new_work.save
        movie.save
        book.save

        expect(Work.spotlight).must_equal album_two

        vote1 = Vote.new
        vote2 = Vote.new
        vote3 = Vote.new

        vote1.work = movie
        vote2.work = movie
        vote3.work = movie

        vote1.user = new_user
        vote2.user = user
        vote3.user = other_user

        vote1.save
        vote2.save
        vote3.save

        expect(Work.spotlight).must_equal movie
      end
    end

    describe "self.by_category" do
      it "returns an empty list for a non-existent category" do
        best_pancakes = Work.by_category("pancake")
        expect(best_pancakes.count).must_equal 0
      end
      it "returns the correctly sorted list for albums" do
        best_albums = Work.by_category("album")
        expect(best_albums.count).must_equal 4
        expect(best_albums[0]).must_equal album_two
        expect(best_albums[1]).must_equal album
        expect(best_albums[2]).must_equal album_three
        expect(best_albums[3]).must_equal album_four
      end

      it "returns the correctly sorted list for book" do
        best_books = Work.by_category("book")
        expect(best_books.count).must_equal 4
        expect(best_books[0]).must_equal book_two
        expect(best_books[1]).must_equal book
        expect(best_books[2]).must_equal book_three
        expect(best_books[3]).must_equal book_four
      end

      it "returns the correctly sorted list for movie" do
        best_movies = Work.by_category("movie")
        expect(best_movies.count).must_equal 4
        expect(best_movies[0]).must_equal new_work
        expect(best_movies[1]).must_equal movie_two
        expect(best_movies[2]).must_equal movie
        expect(best_movies[3]).must_equal movie_three
      end
    end
    # describe "count_rides" do
    #   it "returns nil if the passenger has no rides" do
    #     new_passenger.save
    #     expect(new_passenger.count_rides).must_equal 0
    #   end
    #   it "returns the correct total for the number of rides a passenger has taken" do
    #     new_passenger.save
    #     new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
    #     trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234.00)
    #     trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334.00)

    #     expect(new_passenger.count_rides).must_equal 2
    #     expect(new_passenger.count_rides).must_be_instance_of Integer
    #   end
    # end

    # describe "total_charges" do
    #   it "returns 0 if the rider has no rides" do
    #     new_passenger.save
    #     expect(new_passenger.total_charges).must_equal 0
    #   end

    #   it "must return the total spending of the passenger's trips as a float" do
    #     new_passenger.save

    #     new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
    #     trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234.00)
    #     trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334.00)

    #     expect(new_passenger.total_charges).must_equal 7568.00
    #     expect(new_passenger.total_charges).must_be_instance_of Float
    #   end
    # end

    # You may have additional methods to test
  end
end
