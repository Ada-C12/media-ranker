class VotesController < ApplicationController
  def upvote
    work = Work.find_by(id: params[:work_id])
    
    if work.nil?
      head :not_found
      return
    end
    
    @vote = Vote.new(work_id: work.id, user_id: @user.id)
    
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
      return
    else
      flash[:warning] = "A problem occurred: Could not upvote."
      
      if @vote.errors.any?
        @vote.errors.each do |column, message| 
          flash[column.to_sym] = message
        end
      end
      
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
