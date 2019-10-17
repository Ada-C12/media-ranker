class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true
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

end
