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
    spotlight = works.max_by{|work| work.votes.length}
    return spotlight
    
  end
  
  
end
