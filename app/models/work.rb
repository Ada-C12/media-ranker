class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
  validates :title, presence: true, uniqueness: true
  validates :publication_year, numericality: { only_integer: true, greater_than: 1000 }

  def self.top_ten(category)
    return sorted_works = Work.where(category: category).sort_by { |work| work.votes.count }.reverse!.first(10)
  end

  def self.top_media
    return top_work = self.all.max_by { |work| work.votes.count }
  end

  # a comment
end
