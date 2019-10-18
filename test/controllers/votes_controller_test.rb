require "test_helper"

describe VotesController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe "create" do
    it "adds a vote to user's votes" do
      work = Work.first
      user = User.first
      perform_login(user)
      
      
      expect{ post work_votes_path(work.id)}.must_differ "user.votes.count", 1
      must_respond_with :redirect
      must_redirect_to works_path
      
    end
    it "adds a vote to a work's votes" do
      work = Work.last
      user = User.first
      perform_login(user)
      
      expect{ post work_votes_path(work.id)}.must_differ "work.votes.count", 1
      must_respond_with :redirect
      must_redirect_to works_path
      
    end
    
    it "refuses a vote if no user is logged in" do
      work = Work.first
      user = User.first      
      
      expect{ post work_votes_path(work.id)}.must_differ "work.votes.count", 0
      must_respond_with :success
      
    end
  end
end
