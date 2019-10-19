class Vote < ApplicationRecord
  belongs_to :user, :work
  validates :user_id, uniqueness: { scope: :work_id } #ensures a user has to be present to vote and they can only vote once
end
