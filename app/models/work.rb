class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
validates :category, inclusion: 
{
  in: %w(album book movie),
  message: "%{value} is not a valid category"
}

end
