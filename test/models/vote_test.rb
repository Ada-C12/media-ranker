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
  
  describe "relations" do 
    it 'can access the user and work through "vote"' do
   
      expect _(@vote.user_id).must_equal @user.id
      expect _(@vote.work_id).must_equal @work.id
    end
    
    it 'can set the user and work through "vote"' do
      
      user = User.create!(name: "test user")
      work = Work.create!(category: "movie", title: "test work")
      vote_2 = Vote.new(user_id: 451, work_id: 997)

      vote_2.user_id = user.id
      vote_2.work_id = work.id

      expect _(vote_2.user_id).must_equal user.id
      expect _(vote_2.work_id).must_equal work.id

      end
    
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
    
  end
  
end
