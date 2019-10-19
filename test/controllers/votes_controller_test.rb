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
      
      describe "if user never voted for this work, can create vote with correct attribs..." do
        
        it "... and redirected to same Works index page and see flash msg" do
          login(user6)
          assert(session[:user_id] == user6.id)
          assert(user6.votes.count == 0)
          
          get works_path
          assert(session[:origin_prefix] == "works")
          
          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 1
          db_vote = Vote.last
          assert(db_vote.user == user6)
          assert(db_vote.work == movie1)
          
          assert(flash[:success] == "Successfully upvoted!")
          must_redirect_to works_path
        end
        
        it "... and redirected to same Works/:id show page and see flash msg" do
          login(user6)
          assert(session[:user_id] == user6.id)
          assert(user6.votes.count == 0)
          
          get work_path(id: movie1.id)
          assert(session[:origin_prefix] == "work")
          
          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 1
          db_vote = Vote.last
          assert(db_vote.user == user6)
          assert(db_vote.work == movie1)
          
          assert(flash[:success] == "Successfully upvoted!")
          must_redirect_to work_path(id: movie1.id)
        end
        
      end
      
      it "if user already voted for this work item, should NOT create vote" do
        ###
      end
      
    end
    
  end
  
end
