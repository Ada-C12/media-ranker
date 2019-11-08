class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def self.spotlight
    spotlight = Work.all.order(total_votes: :desc).first
    if spotlight == nil
      spotlight = []
    end
    return spotlight 
  end
  
  def self.sort_desc(category)
    return Work.where(category: category).order(total_votes: :desc)
  end
  
  def self.top_10(category)
    top_10 = Work.where(category: category).order(total_votes: :desc).first(10) 
    if top_10 == nil
      top_10 = []
    end
    return top_10
  end
end
