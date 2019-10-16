class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: { scope: :category }
  
  
  def self.media_sort(category)
    sorted_media = Work.where(category: category)
    return sorted_media
  end
  
  def total_votes
    self.votes.count
  end
  
  def self.top_voted(category)
    Work.where(category: category)
  end
  
  def self.top_ten(category)
    top_ten = Work.all.sample(10)
    
    return top_ten
  end
end
