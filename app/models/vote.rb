class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true, uniqueness: {scope: :work_id}
  validates :work_id, presence: true
  validates :vote_type, presence: true

  def self.all_upvotes
    if Vote.all.empty?
      return nil
    else
      return Vote.all.where(vote_type: "upvote")
    end
  end

  def self.all_downvotes
    if Vote.all.empty?
      return nil
    else
      return Vote.all.where(vote_type: "downvote")
    end 
  end


  def self.find_vote(user_id: user_id, work_id: work_id)
    work = Work.find_by(id: work_id)
    user = User.find_by(id: user_id)
    if work && user
      vote = Vote.find_by(user_id: user_id, work_id: work_id)
      if vote
        return vote
      else
        return []
      end
    else
      return nil
    end
  end
end
