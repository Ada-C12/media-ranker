class Work < ApplicationRecord
  serialize :votes, Array

  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }

  def self.top_three
    sorted_work = Work.order(votes: :desc)
    result = sorted_work.first(3)
    return result
  end
end