class Work < ApplicationRecord
  has_many :votes
  
  def self.top10(type)
    works = Work.where(category: type).all.order(title: :asc)
    return works[0...9]
  end
  
  def self.spotlight
    #temp work item
    return Work.first
  end
  
  def upvote
    # creating a new vote with work id that's passed in as self
    vote = Vote.new(id: self.id)
    
    # knows current user id
    
    # returns params we can use to make a new vote
    
  end
end