class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  def self.top_ten
    return Work.order(votes_count: :desc).limit(10)
  end

  def self.media_spotlight
    return Work.order(votes_count: :desc).limit(1).first
  end

  def self.all_albums
    return Work.where(category: 'album').order(votes_count: :desc).limit(10)
  end

  def self.all_movies
    return Work.where(category: 'movie').order(votes_count: :desc).limit(10)
  end

  def self.all_books
    return Work.where(category: 'book').order(votes_count: :desc).limit(10)
  end
end
