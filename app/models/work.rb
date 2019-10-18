class Work < ApplicationRecord
  
  has_many :votes, dependent: :nullify
  
  validates :category, presence: true, inclusion: { in: %w(movie album book), message: "Only movie/album/book accepted" }
  
  # FUTURE IMPROVEMENT: HOLD UP!!! What about same names but diff category? book vs movie?!
  validates :title, presence: true, uniqueness: true
  validates :published_year, presence: true
  
  def self.spotlight_winner
    # did not account for ties
    winner = self.all.max_by do |piece| 
      piece.votes.count
    end
    if winner.votes.count == 0
      return Work.new(title:"N/A", description: "Absolutely no votes for any of the works, that's why you're seeing this super special default message", published_year:Date.today.year, category: "book", creator: "NOBODY")
    else
      return winner
    end
  end
  
  def self.all_in(category:)
    if ["movie", "book", "album"].include? category
      return Work.where(category: category)
    else
      raise ArgumentError, "CATEGORY must be one of these: movie, album, or book"
    end
  end
  
  def self.top_ten_in(category:)
    all_in_category = self.all_in(category: category)
    ranked = all_in_category.sort_by { |piece| piece.votes.count }
    ranked.reverse!
    return ranked[0..9]
  end
  
end
