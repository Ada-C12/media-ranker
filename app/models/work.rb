class Work < ApplicationRecord
  
  has_many :votes
  
  validates :category, presence: true
  # also must be Movie/Books/Album
  
  validates :title, presence: true, uniqueness: true
  validates :published_year, presence: true
  
  def self.spotlight_winner
    winner = self.all.max_by do |piece| 
      piece.votes.count
    end
    return winner
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
  
  def sort_by_votes(array_of_work_objs)
    #TODO
  end
  
  
  # Could I have DRY'd these up?  IDK...
  def self.all_movies(all_categories_hash)
    return all_categories_hash[:all_movies]
  end
  
  def self.all_albums(all_categories_hash)
    return all_categories_hash[:all_albums]
  end
  
  def self.all_books(all_categories_hash)
    return all_categories_hash[:all_books]
  end  
  
  def self.top_ten_movies(all_categories_hash)
    return all_categories_hash[:all_movies][0..9]
  end
  
  def self.top_ten_albums(all_categories_hash)
    return all_categories_hash[:all_albums][0..9]
  end
  
  def self.top_ten_books(all_categories_hash)
    return all_categories_hash[:all_books][0..9]
  end
  
end
