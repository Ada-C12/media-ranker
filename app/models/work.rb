class Work < ApplicationRecord
  has_many :votes
  
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: {only_integer: true, greater_than: 1000}
  validates :description, presence: true
end
