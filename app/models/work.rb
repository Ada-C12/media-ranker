class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def self.spotlight
    works = Work.all
    max = 0
    work_id = 0

    works.each do |work|
      votes_per_work = work.votes.count
      if votes_per_work > max
        max = votes_per_work
        work_id = work.id
      end
    end

    return works.find_by(id: work_id)
  end
  
  def self.top_10(category)
    return Work.where(category: category).sample(10)
  end
end
