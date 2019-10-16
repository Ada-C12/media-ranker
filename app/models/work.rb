class Work < ApplicationRecord
  
  has_many :votes
  
  validates :category, presence: true
  # also must be Movie/Books/Album
  
  validates :title, presence: true, uniqueness: true
  validates :published_year, presence: true
  
end
