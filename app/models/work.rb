class Work < ApplicationRecord
  has_many :votes
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  
  def self.top_category(category)
    works = self.all 
    top_category = Work.where(category: category)
    return top_category.max_by(10) { |work| work.votes.length }
  end
  
  def self.spotlight
    works = self.all 
    return works.max_by { |work| work.votes.length }
  end
  
end
