require "test_helper"

describe Work do
  describe "validations" do 
    before do
      @work = Work.new(category: "music", title: "smaple title", creator: "sample creator", description: "great music", publication_year: 2000)
    end
    
    it "is valid when all fields are present" do
      result = @work.valid?
      expect(result).must_equal true
    end
    
    it "is invalid without a title" do 
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
    end
    
    it "is valid without a creator" do
      @work.creator = nil
      result = @work.valid?
      expect(result).must_equal false
    end
    
    it "is valid without a description" do
      @work.description = nil
      result = @work.valid?
      expect(result).must_equal false
    end
    
    it "is valid wihout a publication year" do
      @work.publication_year = nil
      result = @work.valid?
      expect(result).must_equal false
    end
    
    it "is invalid if the title is not unique" do
      @work.title = works(:toy).title
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
    
    it "is invalid without a category" do 
      @work.category = nil
      result = @work.valid?
      expect(result).must_equal false
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
      expect(@work.votes.count).must_equal 2
    end
  end
  
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
  end
  
  describe "top_ten method" do
    it "generates a list of top ten category" do 
      top_ten = Work.top_ten("book")
      expect(top_ten).wont_be_empty
    end 
    
    it "returns an empty array when no works" do
      Work.destroy_all
      top_ten = Work.top_ten("book")
      expect(top_ten.length).must_equal 0 
    end
  end
  
  describe "spotlight" do
    it "returns the work with the highest number of votes" do
      3.times do
        Vote.create(user_id: User.last.id, work_id: 1)
      end
      
      expect(Work.spotlight.votes.count).must_equal 3
    end
  end
end 
