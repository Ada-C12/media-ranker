class Work < ApplicationRecord
  has_many :votes
  
  # validations
  validates :name, presence: true
  validates :creator, presence: true
  # _should_ make sure all name-creator combinations must be unique
  validates_uniqueness_of :name, scope: :creator
  validates :category, presence: true
  
  def self.find_highest_voted 
    works_list = Work.all
    
    max = Work.first
    
    works_list.each do |work|
      if work.votes.length > max.votes.length
        max = work
      end
    end
    
    if max.votes.length == 0
      return Work.all.sample
    end
    
    return max
  end
  
  def self.find_top_ten(category)
    list = Work.where(category: category)
    
    sorted_list = list.sort { |a, b|
      r = (b.votes.length <=> a.votes.length)
      if r == 0 && b.published_date && a.published_date
        r = (b.published_date <=> a.published_date)
      end
      r = (b.id <=> a.id) if (r == 0)
      r
    }
    
    top_ten = sorted_list[0..9]
    
    return top_ten
  end
end
