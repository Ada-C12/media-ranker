class VotesController < ApplicationController
  def upvote
      work_id = params["work_id"]
      user_id = session[:user_id]
      @vote = Vote.new(work_id: work_id, user_id: user_id, vote_type: "upvote")
      work = Work.find_by(id: work_id)
      work.vote_count += 1 

    if @vote.save && work.save
      flash[:success] = "Successfully upvoted for #{work.title}"
      redirect_back(fallback_location: works_path)
    else
      flash[:error] = "Did NOT vote successfully"
      redirect_back(fallback_location: works_path)
      return
    end
  end

  def downvote
    work_id = params["work_id"]
    user_id = session[:user_id]
    @vote = Vote.new(work_id: work_id, user_id: user_id, vote_type: "downvote")
    work = Work.find_by(id: work_id)
    work.vote_count -= 1
    
    
    if @vote.save && work.save
      flash[:success] = "Successfully downvoted #{work.title}"
      redirect_back(fallback_location: works_path)
    else
      flash[:error] = "Did NOT downvote successfully"
      redirect_back(fallback_location: works_path)
      return
    end
  end

  
  def destroy
    vote = Vote.find_by(id: params[:id])
    if vote.nil?
      head :not_found
      return
    end
    
    vote_type = vote.vote_type
    if vote.destroy
      if vote_type == "upvote"
        vote.work.vote_count -= 1
        if !vote.work.save
          flash[:error] = "Did NOT delete upvote successfully"
          redirect_back(fallback_location: votes_path)
        end
      elsif vote_type == "downvote"
        vote.work.vote_count += 1
        vote.work.save
        if !vote.work.save
          flash[:error] = "Did NOT delete successfully"
          redirect_back(fallback_location: votes_path)
        end
      end
      
      flash[:success] = "Successfully deleted vote for #{vote.work.title}"
      redirect_back(fallback_location: votes_path)
      return
    else
      flash[:error] = "Did NOT delete successfully"
      redirect_back(fallback_location: votes_path)
    end
  end


  def change_vote
    vote = Vote.find_by(id: params[:id])

    if vote.nil?
      head :not_found
      return
    elsif vote.vote_type == "upvote"
      vote.vote_type = "downvote"
      vote.work.vote_count -= 2
      if vote.save && vote.work.save
        flash[:success] = "Successfully updated vote to downvote for #{vote.work.title}"
        redirect_back(fallback_location: root_path)
      else
        flash[:error] = "Did NOT downvote successfully"
        redirect_back(fallback_location: root_path)
      end
    elsif vote.vote_type == "downvote"
      vote.vote_type = "upvote"
      vote.work.vote_count += 2
      if vote.save && vote.work.save
        flash[:success] = "Successfully updated vote to upvote for #{vote.work.title}"
        redirect_back(fallback_location: root_path)
      else
        flash[:error] = "Did NOT update vote to upvote successfully"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:error] = "Did NOT update vote successfully"
      redirect_back(fallback_location: root_path)
    end
  end


  private
  def vote_params
    return params.require(:vote).permit(:work_id, :user_id, :vote_type)
  end

end