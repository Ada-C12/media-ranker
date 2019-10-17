class Vote < ApplicationRecord
  belongs_to :user 
  belongs_to :work
  validates :user, presence: true, uniqueness: { scope: :work }
  validates :work, presence: true
end
