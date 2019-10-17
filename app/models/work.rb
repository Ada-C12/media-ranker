class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: { scope: :category }
  
  
  def self.media_sort(category)
    sorted_media = Work.where(category: category)
    return sorted_media
  end 
  
  def self.top_voted(category)
    Work.where(category: category)
  end
  
  def self.top_ten(category)
    sorted_media = self.media_sort(category)
    arrange_by_votes = sorted_media.order(votes_count: :desc)
    
    # sorted_media.includes(:votes).group(['user_id'])
    return arrange_by_votes[0..9]
    # top_ten = Work.all.sample(10)
    # return top_ten
  end
end
