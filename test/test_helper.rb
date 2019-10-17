ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require "minitest"
require "minitest/rails"
require "minitest/autorun"
require "minitest/reporters"


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  before do
    @work = works(:exmachina)
    @vote = votes(:vote_1)
    @user = users(:user_1)
  end
  # Add more helper methods to be used by all tests here...
end
