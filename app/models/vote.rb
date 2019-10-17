class Vote < ApplicationRecord
  belongs_to :work
  validates :work, uniqueness: { scope: :user }
  belongs_to :user
  validates :user, uniqueness: { scope: :work }
end
