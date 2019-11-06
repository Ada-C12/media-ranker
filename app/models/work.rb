class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :category, :creator, :publication_year, :description, presence: true
  validates :title, presence: true, uniqueness: true

  def self.select_spotlight
    works = Work.all
    spotlight_work = works.max_by { |work| work.votes.length }
    return spotlight_work
  end

  def self.select_top_ten(category)
    result = Work.where(category: category)
    if result.empty?
      return nil
    else
      sorted_works = result.sort_by do |work|
        -work.votes.count
      end
      if sorted_works.length > 10
        top_ten = sorted_works.take(10)
        return top_ten
      else
        return sorted_works
      end
    end 
  end
end
