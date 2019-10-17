class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes

  def voted? work
    votes.any? { |vote| vote.work.id == work.id }
  end
end
