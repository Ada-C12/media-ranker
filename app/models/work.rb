class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category, message: "has already been taken"}
end
