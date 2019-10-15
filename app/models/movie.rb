class Movie < ApplicationRecord
  
  has_many :votes
  
  ### WAIT... do we even need this???
  # validates: category:
  
  validates :title, presence: true
  validates :creator, presence: true
  validates :published_year, presence: true
end
