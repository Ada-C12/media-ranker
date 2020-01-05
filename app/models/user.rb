class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true
  validates :username, uniqueness: true
end
