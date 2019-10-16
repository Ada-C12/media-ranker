class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true

  def self.spotlight
    works = Work.all
    return works.sample
  end

  def self.top_ten(category)
    works = Work.where(category: category)

    if works == []
      return works
    else
      return works.sample(10)
    end

  end
end
