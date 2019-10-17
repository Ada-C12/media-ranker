class VotesController < ApplicationController
  
  # no View pages needed for votes
  # only needs votes#create
  
  def create
    
    if !session[:user_id]
      flash.now[:error] = "Must be logged in to vote"
      # IDK why, but I need to re-announce @work for rendering to non-Votes pages...
      @work = Work.find_by(id: params[:work_id])
      
      if session[:origin]
        if session[:origin] == "works/show"
          session[:origin] = nil
          render "works/show"
          return
        elsif session[:origin] == "works"
          session[:origin] = nil
          render "works/index"
          return
        end
      else
        flash[:error] = "Impossible! Where did you come from?"
        redirect_to nope_path
        return
      end
      
    else    
      raise  
      #   Vote.new(user_id: session[:user_id], work_id: xxx)
      #   unless Vote.valid?
      #     flash.now(session[:error] = "Vote unsuccessful")
      #     render to 1/2
      #     return
      #   else
      #     flash.now(session[:success] = "Successfully upvoted!")
      #     render to 1/2
      #     return
      #   end
    end
    
  end
  
end