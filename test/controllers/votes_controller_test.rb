require "test_helper"

describe VotesController do
  describe "create" do
    it "can flash a warning when user not logged in" do
      post work_votes_path(works(:test).id)

      # puts "*********************"
      # puts flash[:status]
      # puts flash[:message]
      expect(flash[:status]).must_equal :warning
      expect(flash[:message]).must_equal "A problem occured: You must log in to vote"
      must_respond_with :redirect
    end
  end
end
