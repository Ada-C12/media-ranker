class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }

  def self.all_works_categorized
    all_works_categorized = {}
    all_works_categorized[:albums] = Work.where(category: "album")
    all_works_categorized[:books] = Work.where(category: "book")
    all_works_categorized[:movies] = Work.where(category: "movie")
    return all_works_categorized
  end
  
  def self.top_ten_categorized
    all_works_categorized = self.all_works_categorized
    top_ten_categorized = {}
    all_works_categorized.each do |category, works|
      category_sorted = works.sort_by { |work| -work.votes.count }
      top_ten_categorized[category] = category_sorted[0..9]
    end
    return top_ten_categorized
  end

  def self.spotlight
    top_ten_categorized = self.top_ten_categorized
    number_one_voted = nil
    top_ten_categorized.each do |category, works|
      if number_one_voted == nil
        number_one_voted = works.first
      elsif works.first == nil
        next
      elsif number_one_voted.votes.count < works.first.votes.count
        number_one_voted = works.first
      elsif number_one_voted.votes.count == works.first.votes.count && works.first.votes.last.updated_at > number_one_voted.votes.last.updated_at
        number_one_voted = works.first
      end
    end

    return number_one_voted
  end

  def upvote(user_id)
    new_vote = Vote.new(user_id: user_id, work_id: self.id)
    if new_vote.valid?
      self.votes << new_vote
    end
    return new_vote
  end

end
