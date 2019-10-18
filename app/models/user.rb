class User < ApplicationRecord
  has_many :votes

  def self.alphabetic
    return User.order(name: :asc)
  end
end
