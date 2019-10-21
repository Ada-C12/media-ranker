class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.spotlight
    spotlighted_work = Work.all.sort_by { |work| -work.votes.length }.first
  end

  def self.by_category(category)
    works_list = Work.where(category: category)
    sorted_works = works_list.sort_by { |work| -work.votes.length }.slice(0..9)
    return sorted_works
  end
end
