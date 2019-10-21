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
  
  def self.top_10 
    works = Work.all
    sorted = works.sort {|a,b| b.votes.count <=> a.votes.count}
    top_10 = sorted[0...10]
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
