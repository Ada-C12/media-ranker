class Work < ApplicationRecord
  
  validates :category, presence: true, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: {scope: :category}
  has_many :votes, :dependent => :delete_all
  
  def self.spotlight
    spotlight = Work.all.order(votes_count: :desc).first
    return spotlight
  end
  
  def self.top_ten(category)
    top_ten = Work.where(category: category).order(votes_count: :desc).take(10)
    return top_ten
  end
  
end
