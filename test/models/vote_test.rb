require "test_helper"

describe Vote do
  
  describe "relations" do
    it "should have one user" do
      vote_on_work = votes(:vote_one)
      vote_second_on_work = votes(:vote_two)

      expect(User.find_by(id: vote_on_work.user)).must_be_instance_of User
      expect(User.find_by(id: vote_second_on_work.user)).must_be_instance_of User
    end

    it "should have one work" do
      vote_on_work = votes(:vote_one)
      vote_second_on_work = votes(:vote_two)

      expect(Work.find_by(id: vote_on_work.work)).must_be_instance_of Work
      expect(Work.find_by(id: vote_second_on_work.work)).must_be_instance_of Work
    end
  end
end