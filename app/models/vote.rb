class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work, uniqueness: {scope: :user, message: "Can only vote for a single media once" }
end
