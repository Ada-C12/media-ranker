require "test_helper"

describe User do
  describe "validations" do
    it "can be valid" do
      users = User.all

      users.each do |user|
        assert(user.valid?)
      end
    end

    it "is invalid if a user with the same name already exists" do
      original_user = users(:tina)
      name = original_user.name

      second_user = User.new(name: name)

      refute(second_user.valid?)
    end

    it "is invalid if no name is given" do
      user = users(:tacocat)

      user.name = ""

      refute(user.valid?)
    end
  end

  describe "relationships" do
    it "can have many votes" do
      user = users(:louise)
      work_1 = Work.first
      work_2 = Work.last

      louise_vote_1 = Vote.create(user: user, work: work_1)
      louise_vote_2 = Vote.create(user: user, work: work_2)

      expect(user.votes.count).must_be :>=, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  #custom methods
end
