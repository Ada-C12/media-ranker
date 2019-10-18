class User < ApplicationRecord
  validates :username, presence: true
  validates :votes, uniqueness: {scope: :user_id}

  has_many :votes
end
