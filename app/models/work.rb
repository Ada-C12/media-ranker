class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true

  def self.spotlight
    works = Work.all

    works.max_by do |work|
      work.votes.count
    end
  end

  def self.top_ten(category)
    works = Work.where(category: category)

    if works == []
      return works
    else
      sorted = works.sort_by do |work| 
        -work.votes.count 
      end
    end
    sorted.take(10)
  end

  
end
