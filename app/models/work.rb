class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :category }
  has_many :votes
  
  def self.spotlight
    self.all.min
  end

  def self.top_ten category
    self.where(category: category).sort.take(10)
  end

  def categories
    [:album, :book, :movie]
  end

  def <=>(other)
    case votes.count <=> other.votes.count
      when 1
        -1
      when 0
        title <=> other.title
      when -1
        1
    end
  end
end
