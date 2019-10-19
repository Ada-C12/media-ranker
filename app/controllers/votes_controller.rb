class VotesController < ApplicationController
end

before_action :find_user

private
def find_user
  @current_user = User.find_by(id: session[:user_id])
end