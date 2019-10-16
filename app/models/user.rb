class User < ApplicationRecord
  has_many :vote

  def self.order_by_joined
    return User.order(joined_date: :desc)
  end
end
