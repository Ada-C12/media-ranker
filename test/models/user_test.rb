require "test_helper"

describe User do
  it "can be instantiated" do
    # Arrange
    existing_vote = votes(:user_1_top_album)
    # Assert
    expect(existing_vote.valid?).must_equal true
    expect(existing_vote).must_be_instance_of Vote
  end

  describe "validations" do
    it "cannot be saved to the database without a username" do
      # Act
      user_without_username = User.new()
      expect(user_without_username.valid?).must_equal false
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # Arrange
      user_with_votes = users(:user_1)

      # Assert
      expect(user_with_votes.votes.count).must_be :>=, 0
      user_with_votes.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
