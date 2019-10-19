require 'pry'

class Work < ApplicationRecord
  has_many :votes
  
  def self.spotlight
    @works = Work.all.sample
    # highest_voted = works.max_by { |work| work.votes.length }
    # return highest_voted
  end
  
  
  def self.highest_ten(category)
    works_by_category = Work.where(category: category)
    sorted = works_by_category.sort { |i, j|j.votes.count <=> i.votes.count }
    
    
    return sorted
  end
  
end
