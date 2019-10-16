class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: {scope: :category}
  validates_length_of :title, minimum: 1, maximum: 150
  validates :creator, presence: true
  validates_length_of :title, minimum: 1, maximum: 150
  validates :description, presence: true
  validates_length_of :title, minimum: 1, maximum: 500
  validates :publication_year, presence: true

  has_many :votes, dependent: :destroy

  def self.categories
    cat_hash = {}
    Work.all.order(:category).each do |work|
      if !cat_hash[work.category]
        cat_hash[work.category] = true
      end
    end
    return cat_hash.keys
  end

  def self.all_by_votes
    return Work.all.order(vote_count: :desc)
  end

  def self.top_by_category(num:num, category:category)
    return Work.where(category: category).order(vote_count: :desc).first(num)
  end
  
  def self.top_work
    return all_by_votes.first
  end

end

