class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true

  def works_sorted_by_vote
    
  end 
end
