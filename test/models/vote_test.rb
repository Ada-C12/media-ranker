require "test_helper"

describe Vote do
  let (:text_vote) {
    Vote.new(
      user_id: User.first.id,
      work_id: Work.first.id
    )  
  }
  
  describe "initilaiztaion" do
    it "can be instantiated" do
      expect(text_vote.valid?).must_equal true
    end
  end 

  describe "validations" do 
    it "must have a user id" do
      text_vote.user_id = nil

      expect(text_vote.valid?).must_equal false
      expect(text_vote.errors.messages).must_include :user_id
      expect(text_vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end
    it "must have a work id" do
      text_vote.work_id = nil

      expect(text_vote.valid?).must_equal false
      expect(text_vote.errors.messages).must_include :work_id
      expect(text_vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have one user" do
      text_vote.save

      expect(text_vote.user).must_be_instance_of User
    end

    it "can have one work" do
      text_vote.save

      expect(text_vote.work).must_be_instance_of Work
    end
  end
end
