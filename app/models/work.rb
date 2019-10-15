class Work < ApplicationRecord
  validates :category, inclusion: { 
    in: %w(movie book album),
    message: "%{value} is not a valid category" 
  }, 
  allow_nil: true
  validates :title, presence: true
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true
  
  def self.spotlight
    num_works = self.count
    puts num_works
    rand_id = rand(1..num_works)
    spotlight = nil 
    while spotlight.nil?
      spotlight = self.find(rand_id)
    end
    return spotlight
  end
  
  def total_votes
    #to be implemented when you actually connect to votes
  end
end
