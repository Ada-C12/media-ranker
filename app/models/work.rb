class Work < ApplicationRecord
  has_many :votes, dependent: :nullify

  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }

  def self.top_three
    # sorted_work = Work.order((work.votes.count): :desc)
    # result = sorted_work.first(3)
    return Work.first(3)
  end
end