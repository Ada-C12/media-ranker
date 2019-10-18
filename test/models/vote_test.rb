require "test_helper"

describe Vote do
  let (:work) {
    Work.create!(category: "movie", title: "Howl's Moving Castle", creator: "Hayao Miyazaki", publication_year: 2004, description: "Great movie")
  }

  let (:user) {
    User.create!(username: "new user")
  }
  let (:new_vote) {
    Vote.new(work_id: work.id, user_id: user.id)
  }
  describe "relationships" do
    describe "relations with Work" do
      it "belongs to a work and can set the work_id through work" do
        new_vote.work = work
        expect(new_vote.work).must_be_instance_of Work
        expect(new_vote.work_id).must_equal work.id
      end

      it "can set the work through work_id" do
        new_vote.work_id = work.id
        expect(new_vote.work).must_equal work
      end
    end

    describe "relations with User" do
      it "belongs to a user and can set the user_id through user" do
        new_vote.work_id = work.id
        expect(new_vote.user).must_be_instance_of User
        expect(new_vote.user_id).must_equal user.id
      end

      it "can set the user through user_id" do
        new_vote.user_id = user.id
        expect(new_vote.user).must_equal user
      end
    end
  end
end
