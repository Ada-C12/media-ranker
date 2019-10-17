class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: true

  def upvote
    # when upvote
    # date_voted = Date.today
    # creating a new vote with the work_id passed in and the user id that is known by the session
    work = Work.find_by(id: params[:work_id])
    user = @current_user
    vote_params = Vote.new(date_voted: Date.today, work_id: work.id, user_id: user.id)
    return vote_params
  end
end
