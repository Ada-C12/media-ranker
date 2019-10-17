class User < ApplicationRecord
  validates :username, presence: true
  validates_length_of :username, minimum: 1, maximum: 25
  
  has_many :votes, dependent: :destroy

  def self.username_by_id(user_id)
    user = User.find_by(id: user_id)
    if user
      return user.username 
    else
      return nil
    end
  end

  def upvotes
    if self.votes.empty?
      return nil
    else
      return self.votes.where(vote_type: "upvote").order(:created_at)
    end
  end

  def downvotes
    if self.votes.empty?
      return nil
    else
      return self.votes.where(vote_type: "downvote").order(:created_at)
    end
  end

  def already_voted?(work_id)
    work = Work.find_by(id: work_id)
    
    if work
      if self.votes.find_by(work_id: work_id)
        return true
      else
        return false
      end
    else
      return nil
    end
  end

  def already_downvoted?(work_id)
    work = Work.find_by(id: work_id)
    
    if work
      vote = self.votes.find_by(work_id: work_id)
      if vote && vote.vote_type == "downvote"
        return true
      else
        return false
      end
    else
      return nil
    end
  end

  def already_upvoted?(work_id)
    work = Work.find_by(id: work_id)
    
    if work
      vote = self.votes.find_by(work_id: work_id)
      if vote && vote.vote_type == "upvote"
        return true
      else
        return false
      end
    else
      return nil
    end
  end





end
