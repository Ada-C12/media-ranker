class Work < ApplicationRecord
  # validations
  validates :title, presence: true, uniqueness: true

  def self.top_ten(category)
    works = Work.where(category: category)
    n = works.length
    if n > 10
      return works.sample(10)
    else
      return works
    end
  end
end
