class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  def self.vote_count(user)
    return Vote.where(user_id: user.id).count
  end
  
end
