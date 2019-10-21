class User < ApplicationRecord
  has_many :votes
  
  # validations
  
  validates :username, uniqueness: true, presence: true
end
