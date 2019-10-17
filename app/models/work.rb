class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :category}
  
  def self.top_ten(category)
    all_works = self.all
    ten_works = []
    all_works.each do |work|
      if work.category == category
        ten_works << work
      end
    end
    return ten_works.slice(0..9)
  end
  
  def self.spotlight
    return self.all.first
  end
end
