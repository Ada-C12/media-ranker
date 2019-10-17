class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :publication_year, numericality: true
  validates :category, presence: true
end
