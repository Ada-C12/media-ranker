require "test_helper"

describe User do
  let (:valid_user) {
    users(:valid_user)
  }
  it "can be instantiated" do
    expect(valid_user.valid?).must_equal true
  end

  it "will have the required fields" do
    expect(valid_user.username).wont_be_nil
    expect(valid_user).must_respond_to :username
  end

  describe "relationships" do
    it "can have many votes" do
      vote = votes(:valid_vote)

      expect(valid_user.votes.count).must_be :>=, 0
      valid_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      invalid_user = users(:invalid_user)

      expect(invalid_user.valid?).must_equal false
      expect(invalid_user.errors.messages).must_include :username
      expect(invalid_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
end
