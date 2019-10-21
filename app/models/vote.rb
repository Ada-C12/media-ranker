class Vote < ApplicationRecord
  validates :user_id, presence: true
  validates :work_id, presence: true
  validates :date, presence: true
  
  belongs_to :user
  belongs_to :work
end
