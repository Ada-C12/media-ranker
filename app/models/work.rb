class Work < ApplicationRecord
  validates :category, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: {scope: :category}
end
