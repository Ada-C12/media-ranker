class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def votes
    #everytime user hits upvote, add that user to the users_who_voted array for that specific work 
    users_who_voted = []
    users_who_voted.push(@user)
    return users_who_voted 
  end 

  def vote_count
    return votes.length
  end 
end
