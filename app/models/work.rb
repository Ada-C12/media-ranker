class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: { scope: :category}
  
  def self.top_ten(category)
    all_works = self.all
    ten_works = []
    all_works.each do |work|
      if work.category == category
        ten_works << work
      end
    end
    ten_works.sort_by!{|work| work.votes.count }
    ten_works.reverse!
    return ten_works.slice(0..9)
  end
  
  def self.spotlight
    return self.all.max_by{|work| work.votes.count}
  end
  
  def upvote(user_id)
    @work = Work.find_by(id: self.id)
    current_user = User.find_by(id: user_id)
    @work.votes << Vote.create(user_id: user_id)
  end
end
