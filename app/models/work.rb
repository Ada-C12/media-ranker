class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :category }
  has_many :votes
  
  def self.spotlight
    self.first
  end

  def self.top_ten category
    self.where(category: category).take 10
  end

  def categories
    [:album, :book, :movie]
  end
end
