class User < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true, allow_blank: false
  has_many :votes
end
