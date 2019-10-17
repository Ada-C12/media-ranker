
class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  def self.find_top_10(category)

    category_list = Work.where(category: category)
    # Approach #2: Use an enumerable method like sort_by (like map)
    # First: Find out what the whole thing returns ... It returns a sorted array
    # Second: Find out what you put "inside the block" (in-between do and end) ... Logic that evaluates how to sort. This is very specific to sort_by ... such that, we should look up documentation

    sorted_array = category_list.sort_by do |work|
      # Sort by the number of votes a work has
      -work.votes.count
    end
    return sorted_array.slice(0..9)
  end 

  def self.find_spotlight(work)
    # all_works = Work.all

    spotlight = work.sort_by do |work1|
      -work1.votes.count
    end 

    return spotlight.first
  end
end
