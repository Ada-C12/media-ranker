class Work < ApplicationRecord
  has_many :votes
  
  # validations
  validates :title, presence: true, uniqueness: true
  validates :publication_date, numericality: { only_integer: true, greater_than: 3}
  
  def self.topten(category)
    media = Work.where(category: category.to_s)
    topten = media.sort_by {|work| work.votes.length}.reverse
    return topten[0..9]
  end
  
  def self.spotlight
    spotlight_list = Work.all
    spotlight = spotlight_list.sort_by {|work| work.votes.length}.reverse
    return spotlight.first
  end
  
end

