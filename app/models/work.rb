class Work < ApplicationRecord

  validates :category, presence: true, inclusion: { in: ["album", "book", "movie"] }
  validates :title, presence: true, uniqueness: {scope: :category}
  # has_many :votes
end
