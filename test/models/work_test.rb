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
      invalid_work_category = Work.create(category: nil, title: "Test Title", creator: "Test book creator", publication_year: 2017, description: "Test book description")

      expect(invalid_work_category.valid?).must_equal false
      expect(invalid_work_category.errors.messages).must_include :category
      expect(invalid_work_category.errors.messages[:category]).must_equal ["can't be blank"]
    end
    
    it "must have a title" do
      invalid_work_title = Work.create(category: "book", title: nil, creator: "Test book creator", publication_year: 2017, description: "Test book description")

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

      it "returns a work if there are no votes" do
        Vote.destroy_all
        expect(Vote.count).must_equal 0

        expect(Work.most_votes).must_be_instance_of Work
      end
    end

    describe "sort_by_votes" do
      let (:movie2) {
          works(:movie2)
        }
      it "sorts works accurately" do
        expect(valid_work.votes.count).must_equal 1
        expect(movie2.votes.count).must_equal 0

        expect(Work.top_ten("movie").first).must_equal valid_work
        expect(Work.top_ten("movie").last).must_equal movie2
      end
    end

    describe "top-ten" do
      describe "top_ten(movie)" do
        let (:movie2) {
          works(:movie2)
        }
        it "returns accurate top ten movies with most votes" do
          expect(valid_work.votes.count).must_equal 1
          expect(movie2.votes.count).must_equal 0

          expect(Work.top_ten("movie").first).must_equal valid_work
          expect(Work.top_ten("movie").last).must_equal movie2
        end

        it "only includes movies" do
          Work.top_ten("movie").each do |work|
            expect(work.category).must_equal "movie"
          end
        end

        it "returns empty list if no movies" do
          # votes must be deleted to delete works due to foreign key
          Vote.destroy_all
          Work.destroy_all
          expect(Work.count).must_equal 0

          expect(Work.top_ten("movie")).must_be_empty
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

          expect(Work.top_ten("book").first).must_equal book
          expect(Work.top_ten("book").last).must_equal book2
        end

        it "only includes books" do
          Work.top_ten("book").each do |work|
            expect(work.category).must_equal "book"
          end
        end

        it "returns empty list if no books" do
          # votes must be deleted to delete works due to foreign key
          Vote.destroy_all
          Work.destroy_all
          expect(Work.count).must_equal 0

          expect(Work.top_ten("book")).must_be_empty
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

          expect(Work.top_ten("album").first).must_equal album
          expect(Work.top_ten("album").last).must_equal album2
        end

        it "only includes albums" do
          Work.top_ten("album").each do |work|
            expect(work.category).must_equal "album"
          end
        end

        it "returns empty list if no albums" do
          # votes must be deleted to delete works due to foreign key
          Vote.destroy_all
          Work.destroy_all
          expect(Work.count).must_equal 0

          expect(Work.top_ten("album")).must_be_empty
        end
      end
    end
  end
end
