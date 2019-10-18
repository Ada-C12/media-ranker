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
    return ten_works.slice(0..9)
  end
  
  def self.spotlight
    return self.all.first
  end
  
  def upvote(user_id)
    @work = Work.find_by(id: self.id)
    current_user = User.find_by(id: user_id)
    @work.votes << Vote.create(user_id: user_id)
  end
end
