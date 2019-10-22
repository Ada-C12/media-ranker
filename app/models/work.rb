class Work < ApplicationRecord
  
  validates :name, presence: true
  
  validates :category, inclusion: { in: %w(album book movie), message: "%{value} is not a valid category" }
  
  validates_uniqueness_of :name, :scope => [:category]
  
  has_many :votes
  
  
  # create class methods in order to access all the instances of work at once to produce a list of top works for each category and the highest voted work as the spotlight 
  def self.find_spotlight
    
    votes = Vote.all
    work_id = {}
    votes.each do |vote|
      if work_id.has_key?(vote.work_id)
        work_id[vote.work_id] += 1
      else
        work_id[vote.work_id] = 1
      end
    end
    sorted_work_ids = work_id.sort_by{|key, value| value}.reverse
    
    spotlight = Work.find_by(id: sorted_work_ids[0][0])
    
    return spotlight
    
  end
  
  def self.find_top_books
    #get a list of all books
    top_books = Work.where(category: "book")
    
    #populate a hash with all the book_ids and each book's votes as the value
    book_ids = {}
    top_books.each do |book|
      book_ids[book.id] = book.votes.count
    end
    
    #order the hash using the number of votes. Reverse it so it's in descending order. Create a copy because sort_by isn't destructive.
    ordered_book_ids = book_ids.sort_by{|key,value| value}.reverse
    
    #create a collection of instances of work that correspond with the ids
    top_books = []
    ordered_book_ids.each do |book, votes|
      top_books << Work.find(book)
    end
    
    #keep only the first 10 
    until top_books.length <= 10
      top_books.pop
    end
    
    return top_books
  end
  
  def self.find_top_movies
    top_movies = Work.where(category: "movie")
    
    movie_ids = {}
    top_movies.each do |movie|
      movie_ids[movie.id] = movie.votes.count
    end
    
    ordered_movie_ids = movie_ids.sort_by{|key,value| value}.reverse
    
    top_movies = []
    ordered_movie_ids.each do |movie, votes|
      top_movies << Work.find(movie)
    end
    
    until top_movies.length <= 10
      top_movies.pop
    end
    
    return top_movies
  end
  
  def self.find_top_albums
    top_albums = Work.where(category: "album")
    
    album_ids = {}
    top_albums.each do |album|
      album_ids[album.id] = album.votes.count
    end
    
    ordered_album_ids = album_ids.sort_by{|key,value| value}.reverse
    
    top_albums = []
    ordered_album_ids.each do |album, votes|
      top_albums << Work.find(album)
    end
    
    until top_albums.length <= 10
      top_albums.pop
    end
    
    return top_albums
  end
  
  
  
end
