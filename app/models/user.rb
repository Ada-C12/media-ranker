class User < ApplicationRecord
  serialize :votes, Array

  validates :name, presence: true
end
