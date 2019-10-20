class User < ApplicationRecord
  has_many :votes

  # validations

  validates :username, presence: true
end
