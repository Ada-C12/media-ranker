class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  
  validates :title, :category, presence: true
  validates :title, uniqueness: { scope: :category }
  
  def self.works_sorted_by_category(category)
    works = Work.where(category: category)
    return works.sort {|a,b| b.votes.length <=> a.votes.length }  
  end

  def self.top_works(category)
    sorted_works = Work.works_sorted_by_category(category)
    if sorted_works.length > 10
      return sorted_works.slice(0...10)
    end
    return sorted_works
  end

  def self.highest_rated_work
    return Work.all.max_by{ |work| work.votes.length }
  end
end
