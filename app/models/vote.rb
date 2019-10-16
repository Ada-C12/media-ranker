class Vote < ApplicationRecord
  belongs_to :work
  validates :work, uniqueness: { scope: :user }
  belongs_to :user
end
