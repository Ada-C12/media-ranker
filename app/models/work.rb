class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true

  #Each work must have at least a title that is unique within its category - album, book, or movie.
end
