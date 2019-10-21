require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  describe Vote do

    describe "validations" do

      it "can be valid" do
        is_valid_vote = votes(:valid_vote)
        assert_equal( is_valid_vote.user_id, 1)
        assert_equal( is_valid_vote.work_id, 1)
      end
  
      it "is invalid if there is no user id" do
        vote = votes(:invalid_vote_without_user_id)
        assert_nil(vote.user_id )
      end

      it "is invalid if there is no work id" do
        vote = votes(:invalid_vote_without_work_id)
        assert_nil(vote.work_id )
      end
      
    end

  end
end
