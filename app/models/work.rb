class Work < ApplicationRecord
  
  has_many :votes, dependent: :nullify
  
  validates :category, presence: true, inclusion: { in: %w(movie album book), message: "Only movie/album/book accepted" }
  
  # HOLD UP!!! What about same names but diff category? book vs movie?!
  validates :title, presence: true, uniqueness: true
  validates :published_year, presence: true
  
  def self.spotlight_winner
    winner = self.all.max_by do |piece| 
      piece.votes.count
    end
    return winner
  end
  
  def self.all_in(category:)
    if ["movie", "book", "album"].include? category
      return Work.where(category: category)
    else
      raise ArgumentError, "CATEGORY must be one of these: movie, album, or book"
    end
  end
  
  def self.top_ten_in(category:)
    if ["movie", "book", "album"].include? category
      # all = Work.where(category: category).order(:votes.count, :des)
      all = Work.where(category: category)
      return all[0..10]
    else
      raise ArgumentError, "CATEGORY must be one of these: movie, album, or book"
    end
  end
  
end
