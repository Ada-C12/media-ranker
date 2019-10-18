class Work < ApplicationRecord
  has_many :votes
  
  def self.top10(type)
    works = Work.where(category: type).all.order(title: :asc)
    return works[0...9]
  end
  
  def self.spotlight
    #temp work item
    return Work.first
  end
  
  def upvote(current_user)
    work_id = self.id
    vote_params = {work_id: work_id, user_id: current_user.id}
    
    return vote_params
    
  end
end