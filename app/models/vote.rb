class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work


  def self.user_already_vote?(work, user)
    # user = User.find_by(id: params[:id])
    # work = Work.find_by(id: params[:id])

    all_votes = Vote.all

    all_votes.each do |vote|
      if vote[:work_id] == work.id && vote[:user_id] == user.id
        # flash[:error] = "Could not upvote. The user has already voted for this work."
        # redirect_to works_path
        return false
      end
    end

    Vote.create!(work_id: work.id, date: Time.now, user_id: user.id)

    return true
    # flash[:success] = "Successfully upvoted!"
    # redirect_to works_path
  end
end 
