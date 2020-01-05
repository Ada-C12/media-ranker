require "test_helper"

describe User do
  describe "validations" do 
    before do
      @user = User.new(name: "test user")
    end
    
    it "is valid when all fields are present" do
      result = @user.valid?
      expect(result).must_equal true
    end
    
    it "is invalid without a name" do 
      @user.name = nil
      result = @user.valid?
      expect(result).must_equal false
    end 
    
    it "is invalid if the name is not unique" do
      @user.name = users(:ada).name
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name
    end
  end
  
  describe "relationships" do 
    before do
      @work = Work.create(category: "music", title: "smaple title", creator: "sample creator", description: "great music", publication_year: 2000)
      @user = User.create(name: "test user")
      
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
    end
    
    it "can have many votes" do
      expect(@user.votes.count).must_equal 2
    end
  end
end
