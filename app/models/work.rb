class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: true
  validates :category, inclusion: 
  {
    in: %w(album book movie),
    message: "%{value} is not a valid category"
  }
  
  def self.alpha_works
    return Work.order(title: :asc)
  end
    
end
