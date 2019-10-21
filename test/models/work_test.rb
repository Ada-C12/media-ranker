require "test_helper"

describe Work do
  describe "validations" do
    work = Work.first
    it "can be instantiated" do
      expect(work.valid?).must_equal true
    end
    
    it "does not create a work if category is not present" do
      new_work = Work.new(title: "Masterpiece", category: nil)
      expect(new_work.valid?).must_equal false
    end
    
    it "does not create a work if category is not valid" do
      new_work = Work.new(title: "Masterpiece", category: "sfsrs")
      expect(new_work.valid?).must_equal false
      
    end
    
    it "requires a title" do
      new_work = Work.new(title: nil, category: "album")
      expect(new_work.valid?).must_equal false
    end
  end
  
  describe "relationships" do
    it "links votes to a specific work" do
      work = Work.first
      expect(work).must_respond_to :votes
      work.votes.each do |vote|
        expect(vote).must_be_kind_of Vote
      end
    end
    
    it "has a list of voting users" do
      work = Work.first
      work.votes.each do |vote|
        expect(vote.user_id).must_be_kind_of Integer
      end
    end
  end
  
  describe "top ten works method" do 
    it "finds top 10 works correctly" do 
      works = Work.top10("album")
      expect(works[0].title).must_equal "This is the second album"
      expect(works[1].title).must_equal "This is the album"
    end
    
    it "returns the works available if it is less than 10" do 
      works = Work.top10("album")
      expect(works.length).must_equal 2
    end
    
    it "returns an empty array if there are no works" do 
      works = Work.top10("erdfthgyjhu")
      expect(works.length).must_equal 0
    end
    
    it "returns first work if there is a tie" do
      works = Work.top10("book")
      expect(works[0].title).must_equal "Work of Art"
      expect(works[1].title).must_equal "Work of Art2"
    end
  end
  
  describe "finds the spotlight work" do 
    
    it "select the work with the most votes" do
      work = Work.spotlight
      expect(work.title).must_equal "Work of Art No. 2"
    end
  end
  
  describe "upvotes correctly" do
    it "votes for a work" do
      work = Work.spotlight
      votes_count = work.votes.count
      
      user = User.first
      params = work.upvote(user)
      
      expect(params[:work_id]).must_equal work.id
      expect(params[:user_id]).must_equal user.id
    end
    
    it "does not vote if a user is not logged in" do 
      work = Work.spotlight
      votes_count = work.votes.count
      
      expect{ work.upvote() }.must_raise ArgumentError
    end
  end
end
