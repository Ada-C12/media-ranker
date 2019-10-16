class Work < ApplicationRecord
  has_many :votes#, dependent: :nullify
  validates :title, presence: true
  validates :category, presence: true
  validates :release_date, numericality: { only_integer: true}

  def self.top_ten
    works = Work.all
    return works.sample(10)
  end

end
