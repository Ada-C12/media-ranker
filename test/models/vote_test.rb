require "test_helper"
# require "pry"

describe Vote do
  describe "validations" do 
    before do
      @work = Work.create(category: "music", title: "smaple title", creator: "sample creator", description: "great music", publication_year: 2000)
      @user = User.create(name: "test user")
      @vote = Vote.new(user_id: @user.id , work_id: @work.id)
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
  end 
end 
