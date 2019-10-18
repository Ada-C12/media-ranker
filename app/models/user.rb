class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true

  # def works_user_voted
  #   users = self.votes.where(foreign_id: user_id)
  #   return works
  # end 
end
