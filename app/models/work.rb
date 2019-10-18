class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true

  # def users_who_voted
  #   works = self.votes.where(foreign_id: work_id)
  #   return works
  # end 
end
