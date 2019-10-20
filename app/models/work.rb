class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true

  def self.spotlight
    top_work = Work.all.sort_by{|work| work.votes.length}.last
    return top_work
  end 

  def self.top_ten(category)
    works = Work.where(category: category).sort_by{|work| work.votes.length}.reverse
    top_ten = works.slice(0,10)
    return top_ten
  end 
end
