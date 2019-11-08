require "test_helper"

describe User do
  before do
    @new_user = User.new(username: "Raisah")
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@new_user.valid?).must_equal true
    end
  end

  describe "relationships" do 
    it "can have many votes" do
      Vote.create(user_id: @new_user.id, work_id: works(:obama).id)

      expect(@new_user.votes.count).must_be :>=, 0

      @new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
