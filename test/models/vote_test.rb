require "test_helper"

describe Vote do
  describe "validations" do 
    before do
      @work = Work.create(category: "music", title: "smaple title", creator: "sample creator", description: "great music", publication_year: 2000)
      @user = User.create(name: "test user")
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
    end
    
    it "is valid when all fields are present" do
      result = @vote.valid?
      expect(result).must_equal true
    end
    
    it "is invalid without a user_id" do 
      @vote.user_id = nil
      result = @vote.valid?
      expect(result).must_equal false
    end 
    
    it "is invalid without a work_id" do 
      @vote.work_id = nil
      result = @vote.valid?
      expect(result).must_equal false
    end
    
    describe "relations" do
      it "has a user" do
        vote = votes(:vote1)
        _(vote.user).must_equal users(:ada)
      end 
      
      it "can set the user" do
        vote = Vote.new(user_id: "10", work_id: "20")
        vote.user = users(:ada)
        _(vote.user_id).must_equal users(:ada).id
      end
    end
    
    it "has a work" do
      vote = votes(:vote1)
      _(vote.work).must_equal works(:toy)
    end 
    
    it "can set the work" do
      vote = Vote.new(user_id: "10", work_id: "20")
      vote.work = works(:toy)
      _(vote.work_id).must_equal works(:toy).id
    end
  end
end
