require 'pry'

class Work < ApplicationRecord
  has_many :votes
  
  def self.spotlight
    @works = Work.all
    highest_voted = @works.max_by { |work| work.votes.length }
    return highest_voted
  end
  
  # this is returning them all
  def self.highest_ten(category)
    works_by_category = Work.where(category: category)
    sorted = works_by_category.sort { |i, j| j.votes.count <=> i.votes.count }
    
    return sorted[0..9]
  end
  
  def self.list_all(category)
    work_category = Work.all(category: category)
    sorted = works_by_category.sort { |i, j| j.votes.count <=> i.votes.count }
    
    return sorted
  end
end
