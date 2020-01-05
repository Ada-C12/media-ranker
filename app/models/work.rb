
class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  def self.find_top_10(category)

    category_list = Work.where(category: category)

    sorted_array = category_list.sort_by do |work|
      # Sort by the number of votes a work has
      -work.votes.count
    end
    return sorted_array.slice(0..9)
  end 

  def self.find_spotlight(work)
    if work == nil
      return []
    end 

    spotlight = work.sort_by do |work1|
      -work1.votes.count
    end 
    return spotlight.first
  end

  def self.sort_by_category(category)
    list = Work.where(category: category)

    ordered_list = list.sort_by do |work|
      work.votes.length
    end

    return ordered_list.reverse
  end
end
