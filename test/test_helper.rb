ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # Add more helper methods to be used by all tests here...
  
  # # uncomment this once you're done with setting up the User
  # def perform_login(user = User.first)
  #   params = {
  #     user: {
  #       username: user.username
  #     }
  #   }
  #   post login_path(params)
  
  #   expect(session[:user_id]).must_equal user.id
  # end
  
end
