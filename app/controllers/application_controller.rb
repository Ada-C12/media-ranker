class ApplicationController < ActionController::Base

  private
  # If I wanted to bring up a method (maybe used for a controller filter) into AppController, I would still make it private and it would be readable by all controllers

  def find_work

  end

  def logged_in?
    #checking to see if someone has logged in; finding a user
    # @user = 
  end

  def format_categories
    #capitalize/pluralize category wordS?
  end
end

# if work.votes.count = max
# max = work.votes.count (resassign max if work.votes.count is greater than max)
