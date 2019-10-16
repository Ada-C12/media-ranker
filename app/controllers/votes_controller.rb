class VotesController < ApplicationController
  
  # no View pages needed for votes
  # only needs votes#create
  
  # def create
  #   raise
  #   if !session[:user_id]
  #     flash.now(session[:error] = "Must be logged in to vote")
  #     render to 1. work.show page OR 2. work.index page
  #     return
  #   elsif no work found?
  #     ???
  
  #   else      
  #     Vote.new(user_id: session[:user_id], work_id: xxx)
  #     unless Vote.valid?
  #       flash.now(session[:error] = "Vote unsuccessful")
  #       render to 1/2
  #       return
  #     else
  #       flash.now(session[:success] = "Successfully upvoted!")
  #       render to 1/2
  #       return
  #     end
  #   end
  
  # end
  
end