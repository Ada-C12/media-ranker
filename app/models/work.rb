class Work < ApplicationRecord
    has_many :votes 
    validates :title, presence:true 


def self.by_category(category)
return self.where(category: category)
end


end
