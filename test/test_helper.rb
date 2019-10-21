ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  require 'minitest/rails'
  require 'minitest/autorun'
  require 'minitest/reporters'
  #require 'faker'


  def perform_login(user = User.first)
    # can also do user = nil for optional user + the line of code below
    # user ||= User.first
    
    login_data = {
      user: {
        username: user.username,
      },
    }
    post login_path, params: login_data

    # Verify the user ID was saved - if that didn't work, this test is invalid
    expect(session[:user_id]).must_equal user.id

    return user
  end
end
