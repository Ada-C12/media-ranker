class Work < ApplicationRecord
  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 1000 }

  def self.spotlight_media
    return Work.all.sample
  end

  def self.top_books

  end

  def self.top_albums
  end

end
