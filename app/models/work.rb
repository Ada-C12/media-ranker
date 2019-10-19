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
  
  def self.top_ten(category)
    all_of_type = []
    
    # put all objects of provided category in an array
    Work.where(category: "movie").each do |work|
      all_of_type << work
    end
    
    # select the top ten objects by vote count
    top_ten = all_of_type.max_by(10) do |type|       type.votes.count
    end
    
    return top_ten
    
  end
  
  
  
  
end
