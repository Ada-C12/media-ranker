class Work < ApplicationRecord
  def self.all_works_categorized
    all_works_categorized = {}
    all_works_categorized[:albums] = Work.where(category: "album")
    all_works_categorized[:books] = Work.where(category: "book")
    all_works_categorized[:movies] = Work.where(category: "movie")
    return all_works_categorized
  end
  
  def self.top_ten_categorized
    top_ten_categorized = {}
    top_ten_categorized[:albums] = Work.where(category: "album").sample(10)
    top_ten_categorized[:books] = Work.where(category: "book").sample(10)
    top_ten_categorized[:movies] = Work.where(category: "movie").sample(10)
    return top_ten_categorized
  end

  def self.spotlight
    return Work.all.sample
  end
end
