class Work < ApplicationRecord
  has_many :votes
  
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
  
  def self.sort_by_category(category)
    self.where(category: category)
  end
end

