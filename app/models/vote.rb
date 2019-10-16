class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work, uniqueness: { scope: :user }
end
