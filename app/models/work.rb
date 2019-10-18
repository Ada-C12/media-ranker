class Work < ApplicationRecord
  has_many :votes
  
  # validate presence & uniqueness
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
  
  def self.top_ten(cat)
    works_by_cat = self.where(category: cat)
    top_ten = works_by_cat.max_by(10) {|work| work.votes.length}
    return top_ten.compact
  end
  
  def self.spotlight
    works = Work.all
    spotlight = works.max_by{|work| work.votes.length}
    return spotlight
  end
  
  
end
