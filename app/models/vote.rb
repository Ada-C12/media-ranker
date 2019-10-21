class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :work_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, uniqueness: { scope: :work_id, message: "user has already voted for this work" }
  
  def self.create_vote(user_id:, work_id:)
    work = Work.find_by(id: work_id)
    user = User.find_by(id: user_id)
    if !user || !work
      return nil
    else
      return Vote.new(user_id: user_id, work_id: work_id)
    end  
  end
end
