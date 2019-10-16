class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  # MIGHT NOT BE NECESSARY
  # validates :user_id, presence: true
  # validates :work_id, presence: true
end
