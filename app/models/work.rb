class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.sort_by_category(category)
    list = Work.where(category: category)
    return list.sort_by {|work| work.votes.length}.reverse
  end

  def self.spotlight
    Work.all.sort_by {|work| work.votes.length}.reverse.slice(0)
  end
end
