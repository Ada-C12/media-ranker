ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def perform_login(user = nil)
    user ||= User.first
      
    login_data = {
        user: {
          username: user.name,
        }
    }
    post login_path, params: login_data  
    # Verify the user ID was saved - if that didn't work, this test is invalid
    expect(session[:user_id]).must_equal user.id
  
    return user
  end
end
