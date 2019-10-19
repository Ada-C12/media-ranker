require "test_helper"
require 'pry'

describe VotesController do
  
  let (:yml) { let_yml_superhash }
  let (:user6) { yml[:user6] }
  let (:movie1) { yml[:movie1] }
  let (:ctrller) { VotesController.new }
  
  describe "CREATE" do
    
    describe "If user is NOT logged in" do
      it "can't create vote, and get sent back to wherever page u came from with flash msg" do
        get root_path
        refute(session[:user_id])
        refute(session[:origin_prefix])
        expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 0
        
      end
    end
    
    describe "If user is LOGGED IN" do
      it "if user never voted for this work item, should create vote with correct attribs" do
        login(user6)
        assert(session[:user_id] == user6.id)
        
        expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 1
        db_vote = Vote.last
        assert(db_vote.user == user6)
        assert(db_vote.work == movie1)
      end
      
      it "if user already voted for this work item, should NOT create vote" do
      end
      
    end
    
  end
  
end
