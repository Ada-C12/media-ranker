class Work < ApplicationRecord
  has_many :votes
  
  # validate presence & uniqueness
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
  
  def self.top_ten(cat)
    works_by_cat = self.where(category: cat)
    return works_by_cat.sample(10)
  end
  
  def self.spotlight
    works = Work.all
    
    a = 0
    spotlight = works.first
    while a < works.length - 1 do
      if works[a].votes.length < works[a+1].votes.length
        spotlight = works[a+1]
      else
        spotlight = works[a]
      end
    end
    return spotlight
    
  end
  
  
end
