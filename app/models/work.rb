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
  
  
  
  def sort_by_votes(array_of_work_objs)
    #TODO
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
      all = Work.where(category: category).order(:votes.count)
      return all[-10..-1]
    else
      raise ArgumentError, "CATEGORY must be one of these: movie, album, or book"
    end
  end
  
end
