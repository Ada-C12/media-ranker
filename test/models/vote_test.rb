require "test_helper"

describe Vote do
  describe "instantiation" do
    it "can be instantiated" do
      user = users(:user1)
      work = works(:book1)
      new_vote = Vote.new(
        user_id: user.id, 
        work_id: work.id
      )
      expect(new_vote.valid?).must_equal true
    end
    
    it "will have the required fields" do
      vote = Vote.first
      [:user_id, :work_id].each do |field|
        expect(vote).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "can have only one work" do
      vote = Vote.first
      expect(vote.work).must_be_instance_of Work
    end
    
    it "can have only one user" do
      vote = Vote.first
      expect(vote.user).must_be_instance_of User
    end
  end
  
  describe "validations" do
    before do
      @vote = Vote.first
    end
    
    it "must have a user" do
      @vote.user_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user_id
      expect(@vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end
    
    it "must have a work" do
      @vote.work_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :work_id
      expect(@vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end
  end
  
  # describe "custom methods" do
  # end
end

