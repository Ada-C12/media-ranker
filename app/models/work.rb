class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category}
  has_many :votes
  
  #Each work must have at least a title that is unique within its category - album, book, or movie.
  def self.spotlight
    return Work.all.sample
  end 

    #creating a new vote with the work id that is passed in, and the user id that is known by the session 
    #this method should return a hash, which is populated by a user_id, and a work_id
    #the return value of the params will be used in the Vote Create Action in VotesController 
  def upvote(current_user)
    date_voted = Date.today
    work_id = self.id
    user_id = current_user.id 
    # We need to find the value of user_id ...
    # But the easiest/best way for us to get user_id is inside of a Controller, since it's really good at looking at session (and user_id is stored in session)
    # So, if that's the case... if our VotesController is the one that calls this method...
    # AND our VotesController is able to look at session...
    # Could VotesController give the value of user_id from session to this method
    vote_params = {work_id: work_id, user_id: user_id, date_voted: date_voted}
    return vote_params
  end 

end
