class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :work, presence: true
  validates :user, presence: true
  
end
