require "test_helper"

describe Vote do
  let(:valid_vote) {
    Vote.create(work_id: 1, user_id: 1)
  }
  describe "validations" do
    
    it "can be valid" do
      is_valid = valid_vote.valid?

      assert( is_valid )
    end

    it "is invalid if there is no work_id" do
      invalid_vote_without_work_id = Vote.create(work_id: nil)

      is_valid = invalid_vote_without_work_id.valid?

      refute( is_valid )
    end

    it "gives an error message if user tries to vote for the same work twice" do
      # user is voting for the same work twice
      
      invalid_vote = Vote.create(work_id: 1, user_id: 1)

      is_valid = invalid_vote.valid?

      refute( is_valid )
    end
  end

  describe "relations" do
    it "will have a work" do
      vote = votes(:vote1)
      vote.work.must_equal works(:cowboy)
    end

    it "will have a user" do
      vote = votes(:vote1)
      vote.user.must_equal users(:yoshi)
    end
  end
end
