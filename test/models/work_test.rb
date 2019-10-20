require "test_helper"

describe Work do
  describe "validations" do
    it "can be valid" do
      is_valid = works(:valid_work).valid?

      assert(is_valid)
    end

    it "is invalid if there is no title" do
      work = Work.new(category: "movie", title: "", creator: "time curry", publication_year: "1990")

      is_valid = work.valid?

      refute(is_valid)
    end

    it "is invalid if it has the same title as another work in the same category" do
      new_work = Work.new(category: "movie", title: "Clue")

      is_valid = new_work.valid?

      refute(is_valid)
    end

    it "is valid if it has the same title as another work in a different category" do
      new_book = Work.new(category:"book", title: "Clue")

      is_valid = new_book.valid?

      assert(is_valid)
    end
  end

  describe "relationships" do
    it "can have votes" do
      work = works(:valid_work)
      user_1 = users(:valid_user)
      user_2 = users(:valid_user_2)

      vote_1 = Vote.create(user_id: user_1.id, work_id: work.id)
      vote_2 = Vote.create(user_id: user_2.id, work_id: work.id)

      expect(work.votes.count).must_equal 2
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "custom methods" do
    describe "top-ten" do
      it "should display the 10 elements if there 10 or more works listed" do
        movies = Work.top_ten("movie")

        expect(movies.length).must_equal 10
      end
      
      it "should display all works if there are less than 10 pieces of work" do
        works = Work.all
        works.last.destroy

        movies = Work.top_ten("movie")

        expect(movies.length).must_equal 9
      end

      it "should return an empty array if no media for one category" do
        book = Work.find_by(category: "book")
        
        expect(Work.top_ten("movie").length).must_equal 10
        book.destroy

        expect(Work.top_ten("book")).must_be_empty
        expect(Work.top_ten("movie").length).must_equal 10
      end

      it "should display works in descending order by number of votes" do
        user_1 = users(:valid_user)
        user_2 = users(:valid_user_2)

        work_1 = works(:valid_work)
        work_2 = works(:valid_work_1)

        work_2.upvote(user_1.id)
        work_2.upvote(user_2.id)
        work_2.reload

        expect(work_2.votes.count).must_equal 2

        work_1.upvote(user_1.id)
        work_1.reload
        expect(work_1.votes.count).must_equal 1

        expect(Work.top_ten("movie").first).must_equal work_2
      end
    end
    
    describe "spotlight" do
      it "should display one piece of Work" do
        spotlit = Work.spotlight

        expect(spotlit).must_be_instance_of Work
      end

      it "should display the work with most votes" do
        user_1 = users(:valid_user)
        user_2 = users(:valid_user_2)

        work_1 = works(:valid_work)
        work_2 = works(:valid_work_1)

        work_2.upvote(user_1.id)
        work_2.upvote(user_2.id)
        # work_2.reload

        expect(work_2.votes.count).must_equal 2

        work_1.upvote(user_1.id)
        # work_1.reload
        expect(work_1.votes.count).must_equal 1

        expect(Work.spotlight).must_equal work_2
      end
    end

    describe "upvote" do
      it "should create an instance of vote" do
        work = works(:valid_work)
        user = users(:valid_user)

        work.upvote(user.id)

        expect(work.votes.first).must_be_instance_of Vote
      end

      it "should increase the count of votes for a piece of work" do
        work = works(:valid_work)
        user = users(:valid_user)
        user_2 = users(:valid_user_2)

        work.upvote(user.id)
        expect(work.votes.count).must_equal 1

        work.upvote(user_2.id)

        expect(work.votes.count).must_equal 2
      end
    end
  end
end
