class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true
  validates :work_id, presence: true

  def self.all_upvotes
    if Vote.all
      return Vote.all.where(vote_type: "upvote")
    else
      return nil
    end
  end

  def self.all_downvotes
    if Vote.all
      return Vote.all.where(vote_type: "downvote")
    else
      return nil
    end 
  end

end
