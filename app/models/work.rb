class Work < ApplicationRecord
  has_many :votes

  validates :category, :title, :creator, :publication_year, :description, presence: true
  validates :title, uniqueness: true
  validates :publication_year, numericality: { only_integer: true, greater_than: 1900}

  def self.albums_work
    return self.where(category: "album")
  end

  def self.books_work
    return self.where(category: "book")
  end

  def self.movies_work
    return self.where(category: "movie")
  end
end


