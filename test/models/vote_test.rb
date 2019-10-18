require "test_helper"

describe Vote do
  
  before do
    @user = users(:user1)
    @work = works(:kindred)
    @vote = Vote.create(user_id: @user.id, work_id: @work.id)
    
  end
  
  it "can be instantiated" do
    
    expect(@vote.valid?).must_equal true
    
  end
  
  describe "validations" do
    it "is invalid without a work ID" do
      
      @vote.work_id = nil
      
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :work
      
    end
    
    it "is invalid without a user ID" do
      
      @vote.user_id = nil
      
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user
      
    end
    
    it "is invalid without a date" do
      
      @vote.date = nil
      
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :date
      
    end
    
  end
  
end
