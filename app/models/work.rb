class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true

  def upvote
    # when upvote
    #
    # vote_num += 1
    # date_voted = Date.today
    # creating a new vote with the work_id passed in and the user id that is known by the session
    


  end
end
