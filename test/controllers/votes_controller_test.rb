require "test_helper"

describe VotesController do
  describe "upvote" do
    it "cannot be performed if no user logged in" do
      work = works(:list_work_4)

      expect {
        post upvote_path(work.id)
      }.must_differ "Vote.count", 0
      must_redirect_to work_path(work.id)
    end

    it "can upvote a work by a logged-in user if the work hasn't been upvoted" do
      user = perform_login(users(:user1))
      work = works(:list_work_4)

      expect {
        post upvote_path(work.id)
      }.must_differ "Vote.count", 1
      must_redirect_to work_path(work.id)
    end

    it "doesn't allow an user to upvote the same work more one time" do
      user = perform_login(users(:user1))
      work = works(:list_work_4)
      vote = Vote.create(user: user, work: work)

      expect {
        post upvote_path(work.id)
      }.must_differ "Vote.count", 0
      must_redirect_to work_path(work.id)
    end
  end
end
