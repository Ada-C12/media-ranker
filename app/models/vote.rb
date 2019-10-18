class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  validates :user_id, presence: true, uniqueness: { scope: :work }
  validates :work_id, presence: true

end
