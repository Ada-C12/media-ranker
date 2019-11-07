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
    sorted_albums = albums.sort {|a,b| b.votes.count <=> a.votes.count}
    return sorted_albums
  end
  
  def self.all_books
    books = []
    Work.all.each do |work|
      if work.category == "book"
        books << work
      end
    end
    sorted_books = books.sort {|a,b| b.votes.count <=> a.votes.count}
    return sorted_books
  end
  
  def self.all_movies
    movies = []
    Work.all.each do |work|
      if work.category == "movie"
        movies << work
      end
    end
    sorted_movies = movies.sort {|a,b| b.votes.count <=> a.votes.count}
    return sorted_movies
  end
  
  def self.top_10_albums
    works = Work.all_albums
    top_10 = works[0...10]
    return top_10
  end
  
  def self.top_10_books
    works = Work.all_books
    top_10 = works[0...10]
    return top_10
  end
  
  def self.top_10_movies
    works = Work.all_movies
    top_10 = works[0...10]
    return top_10
  end
  
  def self.top_1
    top_votes = 0
    top_work = Work.first
    Work.all.each do |work|
      if work.votes.count > top_votes
        top_work = work
        top_votes = work.votes.count
      end
    end
    return top_work
  end
end
