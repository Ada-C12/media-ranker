require "test_helper"

describe Work do
  
  describe "name validations" do 
    it "upon creation or updating, it does not allow the title to be blank" do
      test_work = Work.new(name: "")
      refute(test_work.valid?)
    end
    
    it "upon creation or updating, it does not allow the title to be a dubplicate title for another work if the category is the same" do
      already_used_username = User.first.username
      test_user = User.new(username: already_used_username)
      refute(test_user.valid?)
    end
  end
  
  describe "category validations" do
    it "upon creationg or updating, it requires the categories to be limited to album, book, or movie" do
      test_work = Work.new(name: "I am a test", category: "bubblegum")
      refute(test_work.valid?)  
      
      test_work = Work.new(name: "I am a test", category: "book")
      assert(test_work.valid?) 
      
    end

  end
end
