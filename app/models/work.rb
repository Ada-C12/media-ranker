class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  
  validates :title, presence: true, uniqueness: { scope: :category }
  
  
  def self.media_sort(category)
    sorted_media = Work.where(category: category)
    return sorted_media
  end 
  
  def self.top_voted
    return Work.order(votes_count: :desc).first
  end
  
  def self.top_ten(category)
    sorted_media = self.media_sort(category)
    arrange_by_votes = sorted_media.order(votes_count: :desc)
    
    return arrange_by_votes[0..9]
  end
end
