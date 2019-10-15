class UsersController < ApplicationController
  has_many :votes
  
  validates :username, presence: true
end
