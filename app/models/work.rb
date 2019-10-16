class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category}
  has_many :votes
  
  #Each work must have at least a title that is unique within its category - album, book, or movie.
  def self.spotlight
    return Work.all.sample
  end 

  def upvote 
    #creating a new vote with the work id that is passed in, and the user id that is known by the session 
    #this method should return a hash, which is populated by a user_id, and a work_id
    #the return value of the params will be used in the Vote Create Action in VotesController 
  end 

end
