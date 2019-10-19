require "test_helper"

describe Vote do

  it "can be instantiated" do
    # Arrange
    existing_vote = votes(:user_1_top_album)
    # Assert
    expect(existing_vote.valid?).must_equal true
    expect(existing_vote).must_be_instance_of Vote
  end

  describe "validations" do
    it "cannot be saved to the database if a vote with the same user_id and work_id already exists" do
      existing_vote = votes(:user_1_top_album)
      new_invalid_vote = Vote.new(user_id: existing_vote.user_id, work_id: existing_vote.work_id)
      expect(new_invalid_vote.valid?).must_equal false
      expect(existing_vote).must_be_instance_of Vote
    end
  end

  describe "relationships" do
    it "has a user and a work" do
      vote_with_user_and_work = votes(:user_1_top_album)
      expect(vote_with_user_and_work.user).must_be_instance_of User
      expect(vote_with_user_and_work.work).must_be_instance_of Work
    end
  end
end
