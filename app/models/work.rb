class Work < ApplicationRecord
  validates :creator, presence: true
  validates :title, presence: true
  has_many :votes
  
  def self.featured
    if Vote.count == 0
      return nil
    end
    featured_work = Work.all.max_by do |work|
      work.votes.count 
    end
    return featured_work
  end
  
  def self.sort(category)
    sorted_work = Work.all.where(category: category ).limit(10).sort_by do |work|
      -work.votes.count
    end
    return sorted_work
  end
end

