class Work < ApplicationRecord
  has_many :votes
  
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: {only_integer: true, greater_than: 1000}
  validates :description, presence: true
  
  def self.all_albums
    albums = []
    Work.all.each do |work|
      if work.category == "album"
        albums << work
      end
    end
    return albums
  end
  
  def self.all_books
    books = []
    Work.all.each do |work|
      if work.category == "book"
        books << work
      end
    end
    return books
  end
  
  def self.all_movies
    movies = []
    Work.all.each do |work|
      if work.category == "movie"
        movies << work
      end
    end
    return movies
  end
end
