require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "validations" do
    before do
      @album = works(:album)
    end
    it "is vaild when all fields are present" do
      assert(@album.valid?)
    end

    it "is invalid if title is blank" do
      @album.title = nil

      refute(@album.valid?)
    end
  end

  describe "relationships" do
    it "can set the Vote through votes" do
      vote = votes(:noworkvote)
      book = works(:book)

      book.votes << vote

      expect(book.votes.first.id).must_equal vote.id
    end
    it "can set the Vote with a collection " do
      votes = [votes(:noworkvote)]
      book = works(:book)

      book.votes = votes

      expect(book.votes.first.id).must_equal votes.first.id
    end
  end

  describe "Spotlight" do
    it "returns the one work with the highest votes" do
      work = Work.spotlight

      expect(work.title).must_equal "A Man Called Ove"
      expect(work.votes.length).must_equal 5
    end
  end

  describe "Top-Ten Method " do
    it "returns 10 books with decreasig number of votes" do
      works = Work.top_ten("book")

      expect(works.length).must_equal 10
      expect(works.first.title).must_equal "A Man Called Ove"
      expect(works.last.title).must_equal "East of Eden"
    end

    it "returns less than 10 if there are less than ten works" do
      works = Work.top_ten("album")

      expect(works.length).must_equal 1
      expect(works.first.title).must_equal "A Night at the Opera"
    end

    it "returns an empty array if there are no works" do
      works = Work.top_ten("movie")

      expect(works.length).must_equal 0
      expect(works).must_be_instance_of Array
    end
  end
end
