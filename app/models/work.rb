class Work < ApplicationRecord
  has_many :votes
  
  # validations
  validates :title, presence: true, uniqueness: true
  validates :publication_date, numericality: { only_integer: true, greater_than: 3}
end
