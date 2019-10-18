ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # Add more helper methods to be used by all tests here...
  def perform_login(user = nil)
    user ||= User.first
    login_data = { user: { username: user.username }}
    
    post login_path, params: login_data
    
    expect(session[:user_id]).must_equal user.id
    return user    
  end
end
