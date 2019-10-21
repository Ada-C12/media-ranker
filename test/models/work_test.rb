require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(title: "cool movie", category: "movie")
  }
  let (:user) {
    User.new(username:"Tester")
  }
  describe "validations" do 
    it "can be instantiated" do 
      expect(new_work.valid?).must_equal true
    end 
    
    it "contains the required fields" do
      new_work.save
      work = Work.first
      [:title, :category].each do |field|
        expect(work).must_respond_to field
      end 
    end
    
    it "must have a title" do 
      new_work.save
      new_work.title = nil 
      refute(new_work.valid?)
    end 
    
    it "must have a category" do
      new_work.save
      new_work.category = nil
      refute(new_work.valid?)
    end 
    
    it "cannot have duplicate titles for the same category" do 
      new_work.save
      expect(Work.create(title: "cool movie", category: "movie").valid?).must_equal false
    end 
    
  end 
  
  describe "relationships" do 
    before do 
      new_work.save
      user = User.create(username: "Testuser")
      another_user = User.create(username: "Some dude")
      vote = Vote.create(work_id: new_work.id, user_id: user.id)
      vote_2 = Vote.create(work_id: new_work.id, user_id: another_user.id)
    end 
    
    it "can have many votes" do 
      expect(new_work.votes[0]).must_be_instance_of Vote 
    end 
    
    it "has an accurate number of votes per work" do 
      expect(new_work.votes.count).must_equal 2
    end 
  end 
  
  describe "custom methods" do 
    describe "spotlight" do 
      before do 
        @user = User.create(username:"beep")
        @another_work = Work.create(title:"First work", category:"book")
        new_work.save
      end 
      
      it "will show the top voted work" do 
        @spotlight_work = Work.spotlight
        expect(@spotlight_work).must_be_instance_of Work 
      end 
      
      it "will display the accurate information for that top voted work" do 
        @vote = Vote.create(user_id:@user.id, work_id:new_work.id)
        @spotlight_work = Work.spotlight
        expect(@spotlight_work.title).must_equal "cool movie"
        expect(@spotlight_work.category).must_equal "movie"
      end
      
      
      it "will show the first work if no works have been voted" do
        @spotlight_work = Work.spotlight
        expect(@spotlight_work).must_equal @another_work 
        expect(@spotlight_work.title).must_equal "First work"
      end
      
    end 
    
    describe "top ten" do 
      #I tried doing fixtures for these tests, and it made my spotlight method tests completely fail. It wasn't able to call spotlight on nilclass, which was confusing because the fixtures were working for every other test.
      #I think its because my spotlight method depends on a database query which doesn't register for the test database. We didn't learn how to excluse fixtures for certain tests, and I wasn't sure how to approach that.
      #Sorry these tests aren't as accurate as they could be, with more test data. I would love to try to figure out how to use fixtures and methods together though.
      before do 
     
        work1 = Work.create(title:"a", category:"movie")
        work2 = Work.create(title:"b", category:"movie")
        work3 = Work.create(title:"c", category:"movie")
        work4 = Work.create(title:"d", category:"movie")
        work5 = Work.create(title:"e", category:"movie")
        @work6 = Work.create(title:"f", category:"movie")
        work7 = Work.create(title:"g", category:"movie")
        work8 = Work.create(title:"h", category:"movie")
        work9 = Work.create(title:"i", category:"movie")
        work10 = Work.create(title:"j", category:"movie")

        user2= User.create(username: "Bloop")
        user.save 
        vote1 = Vote.create(work_id:@work6.id, user_id:user.id)
        vote2= Vote.create(work_id:@work6.id, user_id:user2.id)

        category = "movie"
        @top_ten = Work.top_ten(category)
      end 
      
      it "will return a list of just the top ten works" do 
        expect(@top_ten).must_be_kind_of Array
        expect(@top_ten.length).must_equal 10
      end 
      
      it "will list the top voted work first" do 
        expect(@top_ten.first).must_be_kind_of Work 
        expect(@top_ten.first).must_equal @work6
      end 
    end 
    
    describe "sort_by_vote" do 
      before do 
        @work_book = Work.create(title:"Laptop", category:"book")
        @work_movie = Work.create(title:"Funny", category:"movie")
        @work_album = Work.create(title:"Music", category:"abum")
        new_work.save
      end 
      it "will show you a list of all votes given a category" do
        sorted_by_vote = Work.sort_by_vote("movie")
        expect(sorted_by_vote).must_be_kind_of Array 
        expect(sorted_by_vote.length).must_equal 2
      end 
      
      it "will have votes for the accurate given category" do 
        expect(Work.sort_by_vote("book").length).must_equal 1
      end 
      
    end 
    
    describe "upvote" do

      before do 
        user.save 
        new_work.save
        @vote_params = new_work.upvote(user)
        @upvote = Vote.create(@vote_params)
      end 

      it "will add a vote to a work" do
        expect(@upvote).must_be_instance_of Vote 
        expect(new_work.votes.length).must_equal 1
      end 
      
      it "will not add another vote for the same work for a user" do
        refute(Vote.create(@vote_params).valid?)
      end
      
      it "will have the correct date for the day the work was voted on" do 
        expect(@upvote.date_voted).must_equal Date.today 
      end 
      
    end 
  end 
end
