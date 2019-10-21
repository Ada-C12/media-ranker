require "test_helper"

describe Vote do
  describe "relations" do
    it "has a user" do
      vote = votes(:noworkvote)
      expect(vote.user).must_equal users(:kiki)
    end
    it "can set a user through user" do
      vote = votes(:nouservote)
      user = users(:simba)

      vote.user = user

      expect(vote.user_id).must_equal user.id
    end

    it "can set a user through user_id" do
      vote = votes(:nouservote)
      user = users(:simba)

      vote.user_id = user.id

      expect(vote.user).must_equal user
    end

    it "has a work" do
      vote = votes(:nouservote)
      expect(vote.work).must_equal works(:album)
    end
    it "can set a work through work" do
      vote = votes(:noworkvote)
      work = works(:book)

      vote.work = work

      expect(vote.work_id).must_equal work.id
    end

    it "can set a work through work_id" do
      vote = votes(:noworkvote)
      work = works(:book)

      vote.work_id = work.id

      expect(vote.work).must_equal work
    end
  end
end
