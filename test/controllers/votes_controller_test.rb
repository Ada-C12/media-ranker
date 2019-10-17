require "test_helper"

describe VotesController do
  describe "create" do
    it "can flash a warning when user is not logged in" do
      post work_votes_path(works(:test).id)

      expect(flash[:status]).must_equal :warning
      expect(flash[:message]).must_equal "A problem occured: You must log in to vote"
      must_respond_with :redirect
      must_redirect_to work_path(works(:test))
    end

    it "can flash a warning when the user has already voted for a specific work" do
      perform_login

      current_user = session[:user_id]
      work = Work.find_by(id: works(:oasis).id)
      work_id = work.id

      vote = Vote.new
      vote.user_id = current_user
      vote.work_id = work_id
      vote.save

      post work_votes_path(work)

      expect(flash[:status]).must_equal :warning
      expect(flash[:message]).must_equal "A problem occurred: You have already voted for this work"
    end

    it "can flash a success message when a user upvotes a work" do
      perform_login

      current_user = session[:user_id]
      work = Work.find_by(id: works(:lamar).id)

      post work_votes_path(work)

      expect(flash[:status]).must_equal :success
      expect(flash[:message]).must_equal "You have successfully voted for this work!"
    end

    it "will redirect if the work ID is invalid" do
      perform_login

      current_user = session[:user_id]

      work_id = -1

      post work_votes_path(work_id)

      must_respond_with :redirect
    end

    it "will redirect if the current user is invalid" do
      current_user = -1

      work = Work.find_by(id: works(:coldplay).id)

      post work_votes_path(work)

      must_respond_with :redirect
    end
  end
end
