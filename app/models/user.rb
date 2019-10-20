class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  
  validates :username, presence: true, length: { minimum: 1 }
end
