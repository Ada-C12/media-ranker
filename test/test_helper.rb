ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase  fixtures :all
    
  def perform_login(user)
    params = {
      user: {
        username: user.username
      }
    }
    post login_path(params)
    
    expect(session[:user_id]).must_equal user.id
  end
  
end
