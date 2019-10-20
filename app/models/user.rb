class User < ApplicationRecord
  has_many :votes
  validates :name, presence: true

  def self.alphabetic
    return User.order(name: :asc)
  end
end
