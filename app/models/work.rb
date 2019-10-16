class Work < ApplicationRecord
  has_many :votes

  validates :category, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.spotlight
    spotlight = Work.all.sample(1)
    if spotlight.length == 0
      return spotlight
    else
      return spotlight.first
    end
  end

  def self.top_ten(category)
    # if category needs to be validated, should that go in the controller? 
    category_all = Work.where(category: category)
    top_ten = category_all.sample(10)
    return top_ten
  end
end
