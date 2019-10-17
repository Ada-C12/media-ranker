class Work < ApplicationRecord
  serialize :votes, Hash

  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }

  def self.top_three do 
    Work.order('votes DESC')
    return Work.first(3)
  end
end