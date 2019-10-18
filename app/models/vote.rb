class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work_id, presence: true
  validates :user_id, presence: true


  validates :work, uniqueness: {scope: :user, message: "Can only vote for a single media once" }
end
