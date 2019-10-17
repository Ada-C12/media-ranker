require "test_helper"

describe Work do
  let (:valid_work) {
    works(:movie)
  }
  it "can be instantiated" do
    expect(valid_work.valid?).must_equal true
  end

  it "will have the required fields" do
    expect(valid_work.category).wont_be_nil
    expect(valid_work.title).wont_be_nil
    expect(valid_work.creator).wont_be_nil
    expect(valid_work.publication_year).wont_be_nil
    expect(valid_work.description).wont_be_nil

    [:category, :title, :creator, :publication_year, :description].each do |attribute|
      expect(valid_work).must_respond_to attribute
    end
  end

  describe "relationships" do
    it "can have many votes" do
      vote = votes(:valid_vote)

      expect(valid_work.votes.count).must_be :>=, 0
      valid_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      invalid_work_category = works(:invalid_work_category)

      expect(invalid_work_category.valid?).must_equal false
      expect(invalid_work_category.errors.messages).must_include :category
      expect(invalid_work_category.errors.messages[:category]).must_equal ["can't be blank"]
    end
    
    it "must have a title" do
      invalid_work_title = works(:invalid_work_title)

      expect(invalid_work_title.valid?).must_equal false
      expect(invalid_work_title.errors.messages).must_include :title
      expect(invalid_work_title.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  describe "custom methods" do
    describe "most_votes" do
      before do
        @album = works(:album)
        @book = works(:book)
        @user2 = users(:user2)
      end
      it "returns accurate work with most votes" do
        expect(valid_work.votes.count).must_equal 1
        expect(@album.votes.count).must_equal 1
        expect(@book.votes.count).must_equal 2

        expect(Work.most_votes).must_equal @book
      end

      it "returns in alphabetical order if tied" do
        vote = Vote.create(user: @user2, work: @album)

        expect(@album.votes.count).must_equal 2
        expect(@book.votes.count).must_equal 2

        expect(Work.most_votes).must_equal @album
      end
    end

    describe "top-ten" do
      describe "top_ten_movies" do
        let (:movie2) {
          works(:movie2)
        }
        it "returns accurate top ten movies with most votes" do
          expect(valid_work.votes.count).must_equal 1
          expect(movie2.votes.count).must_equal 0

          expect(Work.top_ten_movies.first).must_equal valid_work
          expect(Work.top_ten_movies.last).must_equal movie2
        end

        it "only includes movies" do
          Work.top_ten_movies.each do |work|
            expect(work.category).must_equal "movie"
          end
        end

        it "returns empty list if no movies" do
          # votes must be deleted to delete works due to foreign key
          Vote.destroy_all
          Work.destroy_all
          expect(Work.count).must_equal 0

          expect(Work.top_ten_movies).must_be_empty
        end
      end

      describe "top_ten_books" do
        let (:book) {
          works(:book)
        }
        let (:book2) {
          works(:book2)
        }
        it "returns accurate top ten books with most votes" do
          expect(book.votes.count).must_equal 2
          expect(book2.votes.count).must_equal 0

          expect(Work.top_ten_books.first).must_equal book
          expect(Work.top_ten_books.last).must_equal book2
        end

        it "only includes books" do
          Work.top_ten_books.each do |work|
            expect(work.category).must_equal "book"
          end
        end

        it "returns empty list if no books" do
          # votes must be deleted to delete works due to foreign key
          Vote.destroy_all
          Work.destroy_all
          expect(Work.count).must_equal 0

          expect(Work.top_ten_books).must_be_empty
        end
      end

      describe "top_ten_albums" do
        let (:album) {
          works(:album)
        }
        let (:album2) {
          works(:album2)
        }
        it "returns accurate top ten albums with most votes" do
          expect(album.votes.count).must_equal 1
          expect(album2.votes.count).must_equal 0

          expect(Work.top_ten_albums.first).must_equal album
          expect(Work.top_ten_albums.last).must_equal album2
        end

        it "only includes albums" do
          Work.top_ten_albums.each do |work|
            expect(work.category).must_equal "album"
          end
        end

        it "returns empty list if no albums" do
          # votes must be deleted to delete works due to foreign key
          Vote.destroy_all
          Work.destroy_all
          expect(Work.count).must_equal 0

          expect(Work.top_ten_albums).must_be_empty
        end
      end
    end
  end
end
