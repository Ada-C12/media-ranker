class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.most_votes
    return Work.all.max_by { |work| work.votes.count }
  end

  def self.sort_by_votes(works)
    return works.sort_by { |work| work.votes.count }.reverse!
  end

  def self.top_ten(category)
    works = sort_by_votes(Work.where(category: category))
    sorted_works = works.sort_by { |work| work.votes.count }.reverse!
    return sorted_works[0...10]
  end
end
