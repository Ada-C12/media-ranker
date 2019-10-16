class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true
  validates :category, presence: true
  
  def self.works_by_category(category)
    return Work.where(category: category)
  end

  def self.top_works_sorted_by_category(category)
    sorted_works = Work.works_by_category(category).sort {|a,b| b.votes.length <=> a.votes.length }  
    if sorted_works.length > 10
      return sorted_works.slice(0...10)
    end
    return sorted_works
  end

  def self.highest_rated_work
    return Work.all.max_by{ |work| work.votes.length }
  end
end
