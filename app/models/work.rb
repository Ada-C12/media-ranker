class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category}
  has_many :votes
  
  #Each work must have at least a title that is unique within its category - album, book, or movie.
  #This current method does not account for if no upvotes have been made yet.
  def self.spotlight
    begin
      Vote.select(:work_id).group(:work_id).order("count(work_id) desc").first.work
    rescue 
      Work.first
    end
    # max_work_count = 0
    # spotlight = ""
    # Work.all.each do |work|
    #   if work.votes.count > max_work_count 
    #     max_work_count = work.votes.count
    #     spotlight = work
    #   end  
    # end
    # return spotlight 
  end 

  #Maybe make a method that lists all works by order of vote
  #Then top ten will call that method
  # def works_sorted_by_votes
  #   Work.joins("left join votes on votes.work_id = works.id").group("works.id").order("count(works.id) DESC").limit(10)
  # end 

  #So we can call this by saying Work.top_ten(movie), Work.top_ten(book)
  #We can sort all of the works by # of votes and select the top ten from that
  #Or we can select the top ten highest 
  def self.top_ten(category)
    # scope :by_category, :joins => :categories, :group => "schools.id", :order => "AVG(reviews.score) DESC"
    # all_works = Work.joins("left join votes on votes.work_id = works.id").group("works.id").order("count(works.id) DESC").limit(10)
    # all_works = Work.by_category.limit(10)
    # all_works.where(category:category).limit(10).order("votes.work_id ASC")
    # end 
    #Need first ten of these works 

    Work.where(category: category).sort_by { |work| work.votes.length }.first(10).reverse 

  end 

  def self.sort_by_vote(category)
    Work.where(category: category).sort_by { |work| work.votes.length }.reverse 
  end 
    #creating a new vote with the work id that is passed in, and the user id that is known by the session 
    #this method should return a hash, which is populated by a user_id, and a work_id
    #the return value of the params will be used in the Vote Create Action in VotesController 
  def upvote(current_user)
    date_voted = Date.today
    work_id = self.id
    user_id = current_user.id 
    vote_params = {work_id: work_id, user_id: user_id, date_voted: date_voted}
    return vote_params
  end 
end