class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :category, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.spotlight
    works = self.all
    spotlight = works.max_by{|work| work.votes.count}
    return spotlight
  end

  def self.top_ten(category)
    all_in_category = Work.where(category: category).order('votes_count DESC NULLS LAST')
    top_ten = all_in_category.take(10)
    return top_ten
  end
end
