require "test_helper"

describe Vote do
  before do
    valid_work
    valid_user
  end
  
  let (:valid_work) {
    works(:valid_work)
  }
  let (:valid_user) {
    users(:valid_user)
  }
  let (:valid_vote) {
    votes(:valid_vote)
  }
  it "can be instantiated" do
    expect(valid_vote.valid?).must_equal true
    expect(valid_vote).must_be_instance_of Vote
    expect(valid_vote).wont_be_nil
  end
  
  it "will have the required fields" do
    expect(valid_vote.user_id).wont_be_nil
    expect(valid_vote.work_id).wont_be_nil

    [:user_id, :work_id].each do |attribute|
      expect(valid_vote).must_respond_to attribute
    end
  end
  
  describe "relationships" do
    it "has relationships to driver and passenger" do
      expect(valid_vote.work).must_be_instance_of Work
      expect(valid_vote.user).must_be_instance_of User
    end
  end
  
  describe "validations" do
    it "must have a user_id" do
      invalid_vote_user = Vote.create(user: nil, work: valid_work)

      expect(invalid_vote_user.valid?).must_equal false
      expect(invalid_vote_user.errors.messages).must_include :user
      expect(invalid_vote_user.errors.messages[:user]).must_equal ["must exist"]
    end

    it "must have a work_id" do
      invalid_vote_work = Vote.create(user: valid_user, work: nil)

      expect(invalid_vote_work.valid?).must_equal false
      expect(invalid_vote_work.errors.messages).must_include :work
      expect(invalid_vote_work.errors.messages[:work]).must_equal ["must exist"]
    end
  end
end
