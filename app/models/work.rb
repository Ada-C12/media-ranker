class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 1}
  validates :description, presence: true
  
  def self.top_ten(category)
    top_ten = Work.where(category: category).sample(10)
  end
  
end
