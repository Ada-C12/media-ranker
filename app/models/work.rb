class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category }

  
end
