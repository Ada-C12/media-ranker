class Work < ApplicationRecord
  has_many :votes
  
  def self.spotlight
    @works = Work.all.sample
    # highest_voted = works.max_by { |work| work.votes.length }
    
    # return highest_voted
  end
  
  def self.highest_ten(category)
    works_by_category = Work.where(category: category)
    sorted = works_by_category.sort { |i, j| i}
    [1, 2, 3].sort { |a, b| b <=> a }
    
    return sorted[-1..-10].compact
  end
  # get the work by the category
  # search for the ten longest votes
  # return that as an array to list through in the erb
  
  
end
