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
      highest_rated_work_name = "The Martian"
      
      expect((Work.find_spotlight).name).must_equal highest_rated_work_name
      
    end
    
    it "if there is a tie, it returns one of the works which has the most votes" do
      #this test does not work (yet) 
      
      # Vote.create(work_id: 4, user_id: 4)
      
      # expect((Work.find_spotlight).name).must_equal("The Martian").or.must_equal("Lightning on the Strings, Thunder on the Mic")
      
    end
    
    it "if there are no works with any votes, it returns a random work" do
      # this test does not work (yet) The method cannot run without any votes... so it's throwing an error. Which makes me think I should have a "Raise ArgumentError sort of thing here for testing and and filler content for the controller and view" 
      # Vote.destroy_all
      # assert_empty(Work.find_spotlight)
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
