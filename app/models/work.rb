class Work < ApplicationRecord

    has_many :votes
   
  
    validates :category, presence: true
    validates :title, presence: true
    validates :creator, presence: true
    validates :publication_year, presence: true
    validates :description, presence: true
   

    def self.sort_by_category(category)
        categories = Work.where(category: category)
        return categories.sort_by { |work| -work.votes.length}
    end

end
