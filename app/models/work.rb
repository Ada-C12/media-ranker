class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: {scope: :category}
  validates_length_of :title, minimum: 1, maximum: 150
  validates :creator, presence: true
  validates_length_of :creator, minimum: 1, maximum: 150
  validates :description, presence: true
  validates_length_of :description, minimum: 1, maximum: 350
  validates :publication_year, presence: true
  validates :vote_count, presence: true

  has_many :votes, dependent: :destroy

  def self.categories
    works_by_cat = Work.all.order(:category)
    if works_by_cat && !works_by_cat.empty?
      cat_hash = {}
      works_by_cat.each do |work|
        if !cat_hash[work.category]
          cat_hash[work.category] = true
        end
      end
      return cat_hash.keys
    else
      return nil
    end
  end

  def self.all_by_votes
    works_by_points = Work.all.order(vote_count: :desc)
    if works_by_points && !works_by_points.empty?
      return Work.all.order(vote_count: :desc)
    else
      return nil
    end
  end

  def self.top_by_category(num:num, category:category)
    works = Work.where(category: category).order(vote_count: :desc).first(num)
    if works && !works.empty?
      return works
    else
      return nil
    end
  end
  
  def self.top_work
    works = all_by_votes
    if works
      return works.first
    else
      return nil
    end
  end

  def upvote_count
    votes = self.votes
    if votes && !votes.empty?
      return self.upvotes.count
    else
      return nil
    end
  end

  def downvote_count
    votes = self.votes
    if votes && !votes.empty?
      return self.downvotes.count
    else
      return nil
    end
  end

  def upvotes
    if self.votes.empty?
      return nil
    else
      return self.votes.where(vote_type: "upvote").order(:created_at)
    end
  end

  def downvotes
    if self.votes.empty?
      return nil
    else
      return self.votes.where(vote_type: "downvote").order(:created_at)
    end
  end


  def rated?
    points = self.votes.count
    upvotes = self.upvotes.count
    downvotes = self.downvotes.count
    
    if points
      if upvotes && !downvotes
        return "- Highly Rated on MediaRanker"
      elsif downvotes && !upvotes
        return "- Poorly Rated on MediaRanker"
      elsif points > 0 && upvotes > downvotes && upvotes > 1
        return "- Highly Rated on MediaRanker"
      elsif points < 0 || downvotes > upvotes 
        return "- Poorly Rated on MediaRanker"
      else
        return nil
      end
    else 
      return nil
    end
  end


end

