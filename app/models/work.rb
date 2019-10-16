class Work < ApplicationRecord
  has_many :votes
  
  validates :category, presence: true, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 1}
  validates :description, presence: true
  
  def self.top_ten(category)
    top_ten = Work.where(category: category).sample(10)
  end
  
  def self.best_work(works)
    spotlight = works.max_by {|work| work.votes.count}
  end
end
