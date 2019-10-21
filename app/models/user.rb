class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true

  def works_by_user
    votes = Vote.where(user_id: self.id)
    works_list = []
    votes.each do |vote|
      works_list  << Work.find_by(id: vote.work_id)
    end
    return works_list
  end
end

