class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category,
  message: "There is already a work with that name in this category" }

  #Each work must have at least a title that is unique within its category - album, book, or movie.

end
