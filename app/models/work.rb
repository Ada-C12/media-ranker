class Work < ApplicationRecord
  has_many :votes
  validates :category, presence: true
  
  def self.top10(type)
    works = Work.where(category: type).sort_by{ |work| - work.votes.length}
    return works[0...9]
  end
  
  def self.spotlight
    return Work.all.sort_by {|work| - work.votes.length }.first
  end
  
  def upvote(current_user)
    work_id = self.id
    vote_params = {work_id: work_id, user_id: current_user.id}
    
    return vote_params
    
  end
end