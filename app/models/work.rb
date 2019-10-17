class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def self.spotlight
    spotlight = Work.first
    return spotlight
  end
  
  def self.top_10_books
    books = Work.where(category: "book")
    top_10_books = books.sample(10)
    return top_10_books
  end

  def self.top_10_albums
    albums = Work.where(category: "album")
    top_10_albums = albums.sample(10)
    return top_10_albums
  end

  def self.top_10_movies
    movies = Work.where(category: "movie")
    top_10_movies = movies.sample(10)
    return top_10_movies
  end
end
