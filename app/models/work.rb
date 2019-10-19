class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true


  #The database can sort and limit for you how?
  def self.sort_by_category(category)
    categories = Work.where(category: category)
    return categories.sort_by { |work| -work.votes.length}
  end

  def self.top_ten(category)
    works = Work.sort_by_category(category)
    return works.take(10).compact
  end

  def self.spotlight
    all_works = Work.all
    all_works.sort_by { |work| -work.votes.length}
    return all_works.first
  end
end
