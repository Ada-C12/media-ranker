class Work < ApplicationRecord
  has_many :votes, dependent: :nullify

  validates :category, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.spotlight
    works = self.all
    spotlight = works.max_by{|work| work.votes.count}
    if spotlight.nil?
      return nil
    else
      return spotlight
    end
  end

  def self.top_ten(category)
    # if category needs to be validated, should that go in the controller? 
    all_in_category = Work.where(category: category).order('votes_count DESC NULLS LAST')
    top_ten = all_in_category.take(10)
    return top_ten
  end
end
