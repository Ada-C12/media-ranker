class Work < ApplicationRecord
  has_many :votes
  # validations
  validates :title, presence: true, uniqueness: true  
  
  def self.top_ten(category)
    works = Work.where(category: category)
    n = works.length
    if n > 10
      return works.sample(10)
    else
      return works
    end
  end
  
  def self.spotlight
    
    works = self.all.sort_by do |work|
      -work.votes.count
    end
    
    if works.count == 0
      return nil
    end
    
    return works.first
  end
end
