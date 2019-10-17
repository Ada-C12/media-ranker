class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category, message: "has already been taken"}
  
  def self.top_ten(category)
    all_works = self.all
    top_ten_works = []
    all_works.each do |work|
      if work.category == category
        top_ten_works << work
      end
    end
    return top_ten_works.slice(0,10)
  end

  def self.spotlight
    return self.all.first
  end
end
