class User < ApplicationRecord
  validates :username, presence: true
  validates_length_of :username, minimum: 1, maximum: 25
  
  has_many :votes, dependent: :destroy

  def self.username_by_id(user_id)
    return User.find_by(id: user_id).username
  end

  def upvotes
    return self.votes.where(vote_type: "upvote")
  end

  def downvotes
    return self.votes.where(vote_type: "downvote")
  end

  def already_voted(work_id)
    if self.votes.find_by(work_id: work_id)
      return true
    else
      return false
    end
  end
end
