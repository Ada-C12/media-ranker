require "test_helper"

describe Vote do
  describe "validations" do
    it "can be valid" do
      is_valid = votes(:vote_one).valid?

      assert(is_valid)
    end
  end

  describe "relationships" do
    it "belongs to a work" do
      work = works(:valid_work)
      vote = votes(:vote_one)
      
      expect(vote.work.title).must_equal work.title
    end
  end

end
