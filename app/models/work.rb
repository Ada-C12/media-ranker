class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }


  def self.all_works_categorized
    all_works_categorized = {}
    all_works_categorized[:albums] = Work.where(category: "album")
    all_works_categorized[:books] = Work.where(category: "book")
    all_works_categorized[:movies] = Work.where(category: "movie")
    return all_works_categorized
  end
  
  def self.top_ten_categorized
    all_works_categorized = self.all_works_categorized
    top_ten_categorized = {}
    all_works_categorized.each do |category, works|
      top_ten_categorized[category] = works.sample(10)
      # once there are votes, works.order(work.votes: :desc).limit(10) ??
    end
    return top_ten_categorized
  end

  def self.spotlight
    return Work.all.sample
  end
end
