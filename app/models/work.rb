class Work < ApplicationRecord
  has_many :votes

  validates :title, prescence: true
end
