class Work < ApplicationRecord
  has_many :votes

  validates :title, uniqueness: { scope: :category, message: "You can't add a work with the same title!"}


  # this method will be used in homepages view and works#index view


  # https://stackoverflow.com/questions/16996618/rails-order-by-results-count-of-has-many-association
  def self.album_list
    return Work
      .where(category: "album")
      .left_joins(:votes)
      .group(:id)
      .order('COUNT(votes.id) DESC')
  end

  def self.book_list
    return Work
    .where(category: "book")
    .left_joins(:votes)
    .group(:id)
    .order('COUNT(votes.id) DESC')
  end

  def self.movie_list 
    return Work
    .where(category: "movie")
    .left_joins(:votes)
    .group(:id)
    .order('COUNT(votes.id) DESC')
  end

  def self.spotlight
    return Work
    .left_joins(:votes)
    .group(:id)
    .order('COUNT(votes.id) DESC')
  end
end
