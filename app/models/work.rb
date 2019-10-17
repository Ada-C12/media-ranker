class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :category}
end
