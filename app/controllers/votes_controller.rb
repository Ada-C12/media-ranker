class VotesController < ApplicationController
  
  # no View pages needed for votes
  # only needs votes#create
  
  def create
    
    # first check if user is logged in
    if !session[:user_id]
      flash[:error] = "Must be logged in to vote"
      
      if session[:origin_prefix]
        redirect_to_origin
        return
      else
        flash[:error] = "Impossible! Where did you come from?"
        redirect_to nope_path
        return
      end
      
    else   
      # then check if user already voted for this work
      user = User.find_by(id: session[:user_id])
      if user
        if user.votes.any?
          first_vote = user.votes.select { |vote| vote.work_id == params[:work_id].to_i }
          if first_vote.any?
            flash[:error] = "You already voted for this, no double dipping!"
            redirect_to_origin
            return
          end
        end
      else
        flash[:error] = "Impossible, session is set when user logged in! Investigate!"
        redirect_to nope_path
        return
      end
      
      # Make new Vote
      vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to_origin
        return
      else
        flash[:error] = "Vote unsuccessful! #{list_error_messages(vote)}"
        redirect_to_origin
        return
      end
    end
    
  end
  
  
  private 
  def redirect_to_origin
    # session[:origin_prefix] should be set as the prefix of the get page we want to return to by this method
    # this method will ...
    # 1. reset session[:origin_prefix] = nil
    # 2. redirect_to session[:origin_prefix]_path, followed by return 
    # 3!!! When u call this method in real life, you STILL need to follow that up with a separate return!!!!
    
    if session[:origin_prefix] == "work"
      redirect_to work_path(id: params[:work_id])
      return
    elsif session[:origin_prefix] == "works"
      redirect_to works_path
      return
    else
      flash[:error] = "oops, haven't accounted for this possibility"
      redirect_to nope_path
      return
    end
  end
  
  
  
end