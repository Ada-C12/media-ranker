class User < ApplicationRecord
  has_many :votes #, dependent: :nullify
  validates :name, presence: true
end
