class User < ApplicationRecord
  has_many :votes

  def self.order_by_joined
    return User.order(joined_date: :desc)
  end
end
