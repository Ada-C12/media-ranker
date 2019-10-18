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
  
  def let_yml_superhash
    # returns a big old hash for drying out of LET statements, 
    # b/c i'm sick of specifying which yml file things come out of,
    # maybe i could've dried this out too, but i'm only doing this one time so whatever
    return { 
      album1: works(:album1), 
      album2: works(:album2),
      book1: works(:book1),
      book2: works(:book2),
      movie1: works(:movie1),
      movie2: works(:movie2),
      movie3: works(:movie3),
      movie4: works(:movie4),
      movie5: works(:movie5),
      movie6: works(:movie6),
      movie7: works(:movie7),
      movie8: works(:movie8),
      movie9: works(:movie9),
      movie10: works(:movie10),
      movie11: works(:movie11),
      
      user1: users(:user1),
      user2: users(:user2),
      user3: users(:user3),
      user4: users(:user4),
      user5: users(:user5),
      user6: users(:user6),
      
      vote1m1: votes(:vote1m1),
      vote1m2: votes(:vote1m2),
      vote1m3: votes(:vote1m3),
      vote1m4: votes(:vote1m4),
      vote1m5: votes(:vote1m5),
      vote1m6: votes(:vote1m6),
      vote1m7: votes(:vote1m7),
      vote1m8: votes(:vote1m8),
      vote1m9: votes(:vote1m9),
      vote1m10: votes(:vote1m10),
      
      vote2m1: votes(:vote2m1),
      vote2m2: votes(:vote2m2),
      vote2m3: votes(:vote2m3),
      vote3m1: votes(:vote3m1),
      vote3m2: votes(:vote3m2),
      vote4m1: votes(:vote4m1),
      
      vote1b1: votes(:vote1b1),
      vote1b2: votes(:vote1b2),
      vote2b2: votes(:vote2b2),
      vote1a1: votes(:vote1a1)
    }
  end
  
  def desc_order?(array_of_Work_objs)
    # manually tested w/ print statements
    if array_of_Work_objs.length == 1
      # BASE CASE
      return true
    elsif array_of_Work_objs[0].votes.count >= array_of_Work_objs[1].votes.count
      # puts array_of_Work_objs[0].title, "with #{array_of_Work_objs[0].votes.count}"
      # puts array_of_Work_objs[1].title, "with #{array_of_Work_objs[1].votes.count}\n\n\n"
      # RECURSE
      return desc_order?(array_of_Work_objs[1..-1])
    elsif array_of_Work_objs[0].votes.count < array_of_Work_objs[1].votes.count
      # not in descending order
      return false
    end
  end
end
