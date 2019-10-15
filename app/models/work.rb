class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :description, presence: true
  validates :publication_year, presence: true, numericality: true

  has_many :votes

  def self.categories
    cats = {}
    Work.all.each do |work|
      if !cats[work.category]
        cats[work.category] = true
      end
    end
    return cats.keys
  end

  def self.top_by_category(num:num, category:category)
    return Work.where(category: category).order(title: :desc).first(num)
  end
  
  def self.media_spotlight
    return Work.all.order(title: :desc).first
  end

end
