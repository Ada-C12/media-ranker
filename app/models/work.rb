class Work < ApplicationRecord
  # validate presence & uniqueness
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
  
  def self.top_ten(cat)
    works_by_cat = self.where(category: cat)
    return works_by_cat.slice(0, 10)
  end
  
  def self.spotlight
    return Work.first
  end
  
end
