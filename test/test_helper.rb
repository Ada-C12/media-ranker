ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # Add more helper methods to be used by all tests here...
  def get_db_user(yml_key:)
    db_user = User.find_by(name: yml_key.name)
    if db_user
      return db_user
    else
      raise ArgumentError, "yml_key doesn't match anything in users.yml"
    end
  end
  
  def get_db_work(yml_key:)
    db_work = Work.find_by(title: yml_key.title)
    if db_work
      return db_work
    else
      raise ArgumentError, "yml_key doesn't match anything in works.yml"
    end
  end
  
  def get_db_vote(yml_key:)
    db_vote = Vote.find_by(user_id: yml_key.user_id)
    if db_vote
      return db_vote
    else
      raise ArgumentError, "yml_key doesn't match anything in votes.yml"
    end
  end
  
  def let_turbo
    # returns a big old hash for serious drying out of before 
    album1 = works(:album1)
    movie1 = works(:movie1)
    return { 
      album1: album1, 
      movie1: movie1,
    }
  
    # let (:album1) { works(:album1) }
    # let (:book1) { works(:book1) }
    # let (:movie1) { works(:movie1) }
    # let (:album2) { works(:album2) }
    # let (:book2) { works(:book2) }
    # let (:movie2) { works(:movie2) }
  end
  
end
