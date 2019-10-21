require "test_helper"

describe Vote do
  before do
    new_work
    new_user
  end

  let (:new_work) {
    works(:new_work)
  }
  let (:new_user) {
    users(:new_user)
  }
  let (:new_vote) {
    votes(:new_vote)
  }
  it "can be instantiated" do
    expect(new_vote.valid?).must_equal true
    expect(new_vote).must_be_instance_of Vote
  end

  it "will have the required fields" do
    [:user_id, :work_id].each do |field|
      expect(new_vote).must_respond_to field
    end
  end

  describe "relationships" do
    it "is connected in a many to one relationship to works and users" do
      expect(new_vote.work).must_be_instance_of Work
      expect(new_vote.user).must_be_instance_of User
    end
  end

  describe "validations" do
    it "must be made for a work" do
      bad_work = Vote.create(user: new_user, work: nil)

      expect(bad_work.valid?).must_equal false
      expect(bad_work.errors.messages).must_include :work
      expect(bad_work.errors.messages[:work]).must_equal ["must exist"]
    end

    it "must be made by a user" do
      bad_user = Vote.create(user: nil, work: new_work)

      expect(bad_user.valid?).must_equal false
      expect(bad_user.errors.messages).must_include :user
      expect(bad_user.errors.messages[:user]).must_equal ["must exist"]
    end
  end
end
