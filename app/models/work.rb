class Work < ApplicationRecord
  
  validates :name, presence: true
  validates :name, uniqueness: true
  
  validates :category, inclusion: { in: %w(album book movie), message: "%{value} is not a valid category" }
  
  has_many :votes
end
