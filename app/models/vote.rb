class Vote < ApplicationRecord

    
  def self.new_vote
    current_user = User.find_by(id: session[:user_id])
    current_work = Work.find_by(id: params[:work][:id])
    vote_hash = {
      user_id: current_user.id,
      work_id: current_work.id,
      date: Date.today
    }
        
    return vote_hash
  end
  
end
