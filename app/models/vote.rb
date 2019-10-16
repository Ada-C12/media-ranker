class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates_uniqueness_of :user_id, scope: :work_id, message: "has already voted for this work" 
  
  # MIGHT NOT BE NECESSARY
  # validates :user_id, presence: true
  # validates :work_id, presence: true
end
