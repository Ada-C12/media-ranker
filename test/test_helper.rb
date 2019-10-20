ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  def perform_login(user = User.first)
    params = {
      user: {
        username: user.username
      }
    }
    post login_path(params)
    
    expect(session[:user_id]).must_equal user.id
  end
  
  
  # Add more helper methods to be used by all tests here...
end


