class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true
  validates :category, presence: true
  
  def self.works_by_category(category)
    return Work.where(category: category)
  end
end
