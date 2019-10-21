class Work < ApplicationRecord
  has_many :votes, :dependent => :destroy
  validates :title, presence: true
  validates :category, presence: true
  
  def self.category_list(category)
    list = Work.where(category: category).sort_by{ |work| - work.votes.length }
    return list
  end

  def self.spotlight
    top = Work.all.sort_by {|work| - work.votes.length }.first
    return top
  end
  
end
