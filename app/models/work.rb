class Work < ApplicationRecord
  has_many :votes
  
  validates :category, presence: true, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 1}
  validates :description, presence: true
  
  def self.top_ten(category)
    all_works = Work.where(category: category)
    
    sorted_works = all_works.sort_by {|work| -work.votes.count}
    
    top_ten = sorted_works[0..9]
  end
  
  def self.best_work(works)
    spotlight = works.max_by {|work| work.votes.count}
  end
end
