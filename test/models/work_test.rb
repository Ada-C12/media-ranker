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
  
  describe "find_spotlight" do
    it "finds the work regardless of category with the most votes" do
      highest_rated_work_id = 1
      
      expect{(Work.find_spotlight).id}.must_equal highest_rated_work_id
      
    end
    
    it "if there is a tie, it returns one of the works which has the most votes" do
      Vote.create(work_id: 4, user_id: 4)
      
      expect {(Work.find_spotlight).id}.must_equal(1).or.must_equal(4)
      
    end
    
    it "if there are no works with any votes, it returns a random work" do
      Vote.destroy_all
      assert_nil{Work.find_spotlight(:@spotlight)}
    end
  end
  
  describe "find_top_works methods" do
    
    it "top <category> shows a maximum of 10 works for a given category" do
      Work.create(name: "Vanessa", category: "movie")
      Work.create(name: "Sontee Jenkins", category: "movie")
      Work.create(name: "Grace Rossiter", category: "movie")
      Work.create(name: "Margie Hendricks", category: "movie")
      Work.create(name: "Kreela", category: "movie")
      Work.create(name: "Angela", category: "movie")
      Work.create(name: "Sam Fuller", category: "movie")
      Work.create(name: "Erika Murphy", category: "movie")
      Work.create(name: "Angela Abar", category: "movie")
      Work.create(name: "Janine Davis", category: "movie")
      
      expect((Work.find_top_movies).count).must_equal 10
    end
    
    
    #the same method is used to determine top albums and books
    
    it "if there are no works for a given category it displays a message" do
      #to be checked using the application as this is in the view because it's done in the view :/  
    end
  end
  
end
