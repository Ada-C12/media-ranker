class Work < ApplicationRecord
  
  has_many :votes
  
  validates :category, presence: true
  # also must be Movie/Books/Album
  
  validates :title, presence: true, uniqueness: true
  validates :published_year, presence: true
  
  def self.spotlight_winner
    return "TBD"
  end
  
  def self.all_categories
    movies = []
    albums = []
    books = []
    everything = { all_movies: movies, all_albums: albums, all_books: books }
    
    Work.all.each do |piece| 
      cat = piece.category
      if cat == "movie"
        movies << piece
      elsif cat == "album"
        albums << piece
      elsif cat == "book"
        books << piece
      else
        raise ArgumentError, "This shouldn't happen, b/c would have validated during Work.create()"
      end
    end
    return everything
  end 
  
  def self.all_movies(all_categories_hash)
    return all_categories_hash[:all_movies]
  end
  
  def self.all_albums(all_categories_hash)
    return all_categories_hash[:all_albums]
  end
  
  def self.all_books(all_categories_hash)
    return all_categories_hash[:all_books]
  end  
  
end
