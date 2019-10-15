class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: { scope: :category }
  
  def self.media_types
    media_types = {}
    
    works = Work.all
    works.each do |item|
      type = item.category
      if media_types[:type].nil?
        media_types[:type] = true
      end
      return media_types
    end
  end
  
  def self.media_sort(category)
    sorted_media = Work.where(category: category)
    return sorted_media
  end
end
