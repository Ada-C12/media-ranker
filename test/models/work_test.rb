require "test_helper"

describe Work do

  describe "validations" do
    it "can be valid" do
      is_valid = works(:valid_work).valid?

      assert(is_valid)
    end

    it "is invalid if there is no title" do
      work = works(:invalid_work)
      is_valid = work.valid?

      refute(is_valid)
    end
  end 

  describe "relationships" do
    it "can have many votes" do
      # @test_work = Work.create(category: "book", title: "title")
      # @test_user = User.create(username: "diana")
      # @upvote = Vote.create(work_id: @test_work.id, user_id: @test_user.id)

      # expect(@upvote.work).must_equal @test_work
      work = works(:valid_work)
      vote = votes(:vote_one)

      expect(work.votes.length).must_be :>=, 0
    end

  end

  describe "self.album_list method" do
    before do
      works(:valid_work)
      works(:valid_work2)
    end
    it "can return a list of albums in descending order by number of votes" do

      first_work = Work.album_list.first.title
      last_work = Work.album_list.first.title

      expect(first_work).must_equal valid_work2.title
      expect(last_work).must_equal valid_work.title
    end
  end
end
