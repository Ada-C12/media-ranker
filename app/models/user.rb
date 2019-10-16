class User < ApplicationRecord
  validates :username, presence: true
  validates_length_of :username, minimum: 1, maximum: 25
  
  has_many :votes, dependent: :destroy
end
