class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category}
  has_many :votes
  
  
  #Account for possibility of no works being voted on 
  def self.spotlight
    begin
      Vote.select(:work_id).group(:work_id).order("count(work_id) desc").first.work
    rescue 
      Work.first
    end
  end 

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| -work.votes.length }.first(10)
  end 

  def self.sort_by_vote(category)
    Work.where(category: category).sort_by { |work| work.votes.length }.reverse 
  end 
  
  def upvote(current_user)
    date_voted = Date.today
    work_id = self.id
    user_id = current_user.id 
    vote_params = {work_id: work_id, user_id: user_id, date_voted: date_voted}
    return vote_params
  end 
end