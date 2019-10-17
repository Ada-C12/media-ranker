require "test_helper"
require 'pry'

describe Vote do
  let (:new_vote) {
    Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id)
  }

  it "can be instantiated" do
    expect(new_vote.valid?).must_equal true
  end

  it "will have the required fields" do
    new_vote.save
    [:work_id, :user_id].each do |field|
      expect(new_vote).must_respond_to field
    end
  
  end

  describe "relationships" do
    
    it "can have one work" do
      expect(new_vote.work).must_be_instance_of Work
      expect(new_vote.work.title).must_equal "Cool Book"
    end

    it "can have one user" do
      expect(new_vote.user).must_be_instance_of User
      expect(new_vote.user.username).must_equal "Emily"
    end
  
  end

  describe "validations" do
    
    it "must have a work_id" do
      new_vote.work_id = nil

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work_id
      expect(new_vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end
    
    it "must have a user_id" do
      new_vote.user_id = nil

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :user_id
      expect(new_vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end
  
  end

  describe "custom methods" do
    
    it 'self.all_upvotes works correctly' do 
    
    end
    
    it 'self.all_downvotes works correctly' do
    
    end
  end

end
