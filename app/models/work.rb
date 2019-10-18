class Work < ApplicationRecord
  has_many :votes, dependent: :nullify

  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }

  def self.sort(category)
    all_works = Work.where(category: category)
    
    sorted_works = all_works.sort_by {|work| -work.votes.count}
  end

  def self.top_three(category)
    Work.where(category: category).first(3)
  end
end