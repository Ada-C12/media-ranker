class User < ApplicationRecord
  has_many :votes, :dependent => :restrict_with_error
  validates :username, presence: true
end
