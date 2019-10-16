class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  
  def self.top_category(category)
    works = self.all 
    top_category = Work.where(category: category)
    return top_category
  end
  
  def self.spotlight
    works = self.all 
    spotlight = works.sample 
    return spotlight
  end
  
end
