class Work < ApplicationRecord
  
  validates :category, presence: true, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: {scope: :category}
  # has_many :votes
  
  def self.spotlight
    spotlight = Work.all.sample
    return spotlight
  end
  
  def self.top_ten(category)
    top_ten = Work.where(category: category).sample(10)
  end
  
end
