class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category,
  message: "There is already a work with that name in this category" }

  #Each work must have at least a title that is unique within its category - album, book, or movie.
  def self.spotlight
  end 

  def self.categories
    @categories_of_works = {
    "albums" => Work.where(category: "album"),
    "books" => Work.where(category: "book"),
    "movies" => Work.where(category: "movie")
    }
    return @categories_of_works
  end

end
