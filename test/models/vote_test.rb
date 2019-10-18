require "test_helper"

describe Vote do
  before do
    new_work = works(:miller)
    new_user = User.create(username: "Raisah")

    @new_vote = Vote.new(work_id: new_work.id, user_id: new_user.id)
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@new_vote.valid?).must_equal true
    end
  end

  describe "relationships" do 
    it "can have many votes" do
      @new_vote.save
      expect(@new_vote.user).must_be_instance_of User
      expect(@new_vote.work).must_be_instance_of Work
    end
  end
end
