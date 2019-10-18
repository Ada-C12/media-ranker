class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  # validates :work, uniqueness: true
  validates :user, uniqueness: { scope: :work,
    message: "you can nlt vote twice" }
end
