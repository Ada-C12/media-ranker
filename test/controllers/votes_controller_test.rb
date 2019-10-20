require "test_helper"
require 'pry'

describe VotesController do
  
  let (:yml) { let_yml_superhash }
  let (:user6) { yml[:user6] }
  let (:movie1) { yml[:movie1] }
  let (:ctrller) { VotesController.new }
  
  describe "CREATE" do
    
    describe "If user is NOT logged in" do
      
      describe "can't create vote... " do
        
        it "... then redirected to same Works index page and see flash msg" do
          get works_path
          refute(session[:user_id])
          assert(session[:origin_prefix] == "works")

          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 0
          must_redirect_to works_path
          assert(flash[:error] == "Must be logged in to vote")
        end
        
        it "... then redirected to same Works/:id show page and see flash msg" do
          get work_path(id: movie1.id)
          refute(session[:user_id])
          assert(session[:origin_prefix] == "work")

          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 0
          must_redirect_to work_path(id: movie1.id)
          assert(flash[:error] == "Must be logged in to vote")
        end
        
      end
      
    end
    
    describe "If user is LOGGED IN" do
      
      before do
        login(user6)
        assert(session[:user_id] == user6.id)
        assert(user6.votes.count == 0)
      end      
      
      describe "if user never voted for this work, can create vote with correct attribs..." do
        
        it "... then redirected to same Works index page and see flash msg" do
          
          get works_path
          assert(session[:origin_prefix] == "works")
          
          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 1
          db_vote = Vote.last
          assert(db_vote.user == user6)
          assert(db_vote.work == movie1)
          
          assert(flash[:success] == "Successfully upvoted!")
          must_redirect_to works_path
        end
        
        it "... then redirected to same Works/:id show page and see flash msg" do
          
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
      
      describe "if user already voted for this work item, should NOT create vote" do
        before do
          # cast 1st vote
          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 1
        end
        
        it "... then redirected to same Works index page and see flash msg" do
          # cast 2nd vote, get rejected
          get works_path
          assert(session[:origin_prefix] == "works")
          
          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 0
          
          assert(flash[:error] == "You already voted for this, no double dipping!")
          must_redirect_to works_path
        end
        
        it "... then redirected to same Works/:id show page and see flash msg" do
          # cast 2nd vote, get rejected
          get work_path(id: movie1.id)
          assert(session[:origin_prefix] == "work")
          
          expect{post work_create_vote_path(work_id: movie1.id)}.must_differ "Vote.count", 0
          
          assert(flash[:error] == "You already voted for this, no double dipping!")
          must_redirect_to work_path(id: movie1.id)
        end
        
      end
      
    end
    
  end
  
end
