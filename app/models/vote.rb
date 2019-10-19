class Vote < ApplicationRecord
  belongs_to :user, :work
  validates :user, presence: true, uniqueness: { scope: :work } #ensures a user has to be present to vote and they can only vote once
end
