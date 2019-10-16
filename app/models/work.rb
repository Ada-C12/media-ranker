class Work < ApplicationRecord
  has_many :votes, dependent: :cascade
  validates :category, inclusion: { 
    in: %w(movie book album),
    message: "%{value} is not a valid category" 
  }
  validates :title, presence: true
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true
  
  def self.spotlight
    num_works = self.count
    
    if num_works.nil?
      return nil
    end
    
    spot = self.all.sample
    
    return spot
  end
  
  def self.list_all_in_category(target_category)
    all_in_category = self.where(category: target_category)
    # return all_in_category.order(votes: :desc)
    return all_in_category
  end
  
  def self.get_top_ten(target_category)
    all_in_category = self.list_all_in_category(target_category)
    
    if all_in_category.empty?
      return all_in_category
    elsif all_in_category.length < 10
      return all_in_category
    else
      return all_in_category[0,10]
    end
  end
  
  def total_votes
    #to be implemented when you actually connect to votes
  end
end
