class Work < ApplicationRecord
  has_many :votes

  def self.spotlight
    works = Work.all
    return works.sample
  end

  def self.top_ten(category)
    works = Work.where(category: category)
    return works.sample(10)

  end
end
