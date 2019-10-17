class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 1000 }

  def self.find_spotlight
    return nil if Work.count < 1 

    return Work.all.sample
  end

  def self.top_ten(category)
    return nil unless category == :book || category == :album

    all_media = Work.all.where(category: category)

    top_ten = all_media.sample(10)

    return top_ten
  end

end
