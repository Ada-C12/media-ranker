class Work < ApplicationRecord
  # validate presence & uniqueness
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
  
  def category
    where(:category => self.category)
  end
  
end
