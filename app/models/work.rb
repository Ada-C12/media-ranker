class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true
  validates :category, inclusion: 
  {
    in: %w(album book movie),
    message: "%{value} is not a valid category"
  }
  
  def self.alpha_works
    return Work.order(title: :asc)
  end
  
  # def self.movies
  #   return Work.where(category: "movie")
  # end
  
  # def self.albums
  #   return Work.where(category: "album")
  # end
  
  # def self.books
  #   return Work.where(category: "book")
  # end
  
  
end
