class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.by_category(category)
    return self.where(category: category)
  end

  def self.top_ten(category)
    works = Work.by_category(category)
    top = works.sort_by { |work| -work.votes.length }
    return top.take(10)
  end
  def self.spotlight
    works = Work.all
    return works.sort_by { |work| -work.votes.length }.first
  end

  def upvote(user_id)
    # current_user = User.find_by(id: session[:user_id])
    vote_params = {
      work_id: self.id,
      user_id: user_id

    }
    return vote_params
  end
end
