class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.most_votes
    return Work.all.max_by { |work| work.votes.count }
  end

  def self.top_ten_movies
    movies = Work.where(category: "movie")
    sorted_movies = movies.sort_by { |work| work.votes.count }.reverse!
    return sorted_movies[0...10]
  end

  def self.top_ten_books
    books = Work.where(category: "book")
    sorted_books = books.sort_by { |work| work.votes.count }.reverse!
    return sorted_books[0...10]
  end

  def self.top_ten_albums
    albums = Work.where(category: "album")
    sorted_albums = albums.sort_by { |work| work.votes.count }.reverse!
    return sorted_albums[0...10]
  end
end
