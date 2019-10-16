class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: { scope: :category }
  
  
  def self.media_sort(category)
    sorted_media = Work.where(category: category)
    return sorted_media
  end
end
