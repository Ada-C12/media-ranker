class Work < ApplicationRecord
  has_many :votes#, dependent: :nullify
  validates :title, presence: true
  validates :type, presence: true
  #validates :title, presence: true

end
