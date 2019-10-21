class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true

  def self.alpha_order
    return Work.all.order(title: :asc)
  end
  
  def self.spotlight
    works = self.all
    return works.max_by { |work| work.votes.length }
    # works = self.all
    # return works.select { |work| work.votes.max }.first

    # works_array = works.select { |work| work.votes.max }
    # return works_array.first
  end

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| -work.votes.length }.first(10)
  end

end

