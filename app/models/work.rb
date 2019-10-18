class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true

  def self.spotlight
    # spotlight_work = Work.find_by
    works = self.all

    top_work = works.max_by { |work| work.votes.length }

    return top_work

  end

  def self.top_ten(category)
    #self.votes.......... sort by vote highest to lowest per category, take the first 10 from each
    # works_array = [:album, :book, :movie]
    works = Work.where(category: category)

    works_array = []
    works.each do |work|
      works_array << work.votes.length
    end
    return works_array.order(:desc).first(10)
  end

  def upvote
    unless session[:user_id]
      flash[:error] = "You must be logged in to vote!"
      redirect_to root_path
      return
    end
    # current_user = User.find_by(id: params[:user_id])
    work = Work.find_by(id: params[:work_id])
    session[:user_id] = params[:user_id] #current_user.id
    vote_params = Vote.create(date_voted: Date.today, work_id: work.id, user_id: session[:user_id])
    return vote_params
  end
end

