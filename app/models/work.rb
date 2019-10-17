class Work < ApplicationRecord
    has_many :votes 
    validates :title, presence:true 


def self.by_category(category)
return self.where(category: category)

end

def self.top_ten(category)
works = Work.by_category(category)
top = works.sort_by{|work| -work.votes.length }
return top.take(10)

end 
def self.spotlight 
works = Work.all
return  works.sort_by {|work| -work.votes.length}.first 
end 

end
