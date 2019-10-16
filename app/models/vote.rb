class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true
  validates :work_id, presence: true

  def self.all_upvotes
    return Vote.all.where(vote_type: "upvote")
  end

  def self.all_downvotes
    return Vote.all.where(vote_type: "downvote")
  end

end
