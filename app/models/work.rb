class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def self.spotlight
    spotlight = Work.first
    return spotlight
  end
  
  def self.top_10(category)
    return Work.where(category: category).sample(10)
  end

end
