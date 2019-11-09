class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :work, presence: true
  validates :user, uniqueness: { scope: :work,
    message: "you can not vote twice" }
end
