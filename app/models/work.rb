class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 1000 }

  def self.find_spotlight
    return nil if Work.count < 1 

    spotlight = Work.all.max_by { |work| work.votes.length }

    return spotlight
  end

  def self.sort_media(category)
    return nil unless category == :book || category == :album

    all_media = Work.all.where(category: category)
    media_ascending = all_media.sort_by{ |work| work.votes.length }.reverse!

    return media_ascending
  end

  def self.top_ten(category)
    return nil unless category == :book || category == :album

    return Work.sort_media(category).first(10)
  end

end
