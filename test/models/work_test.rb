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
      work = works(:valid_work)
      vote = votes(:vote_one)

      expect(work.votes.length).must_be :>=, 0
    end
  end

  describe "self.album_list method" do
    before do
      @work1 = Work.create(category: "book", title: "title")
      @work2 = Work.create(category: "book", title: "title2")
      @user1 = User.create(username: "diana")
      @user2 = User.create(username: "sam")
    
    end
    it "can return a list of albums in descending order by number of votes" do
      vote = Vote.create(work_id: @work1.id, user_id: @user1.id)
      vote2 = Vote.create(work_id: @work1.id, user_id: @user2.id)

      albums = Work.album_list

      expect(albums.first.title).must_equal @work1.title   
    end
  end
end
