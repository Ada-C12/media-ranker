class Work < ApplicationRecord
  has_many :votes, dependent: :nullify

  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }

  def self.sort(category)
    all_works = Work.where(category: category)
    sorted_works = all_works.sort_by { |work| -work.votes.count}

    return sorted_works
  end

  def self.top
    all_works = Work.all
    sorted_works = all_works.sort_by { |work| -work.votes.count}
    return sorted_works
  end
end