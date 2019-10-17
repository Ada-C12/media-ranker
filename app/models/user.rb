class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true, uniqueness: true
  validates :name, :length => {minimum: 2}
  

  def self.order_by_joined
    return User.order(joined_date: :desc)
  end
end
