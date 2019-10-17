class Vote < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :work, counter_cache: true

  validates :user, uniqueness: { scope: :work,  message: "has already voted for this work" }
end
