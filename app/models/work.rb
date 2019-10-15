class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: { scope: :category }
end
