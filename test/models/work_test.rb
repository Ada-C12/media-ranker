require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe 'validations' do
    it "can be valid" do
      is_valid = works(:valid_work).valid?
      
      assert(is_valid)
    end
    
    it "is invalid if there is no title" do
      work = Work.new(category: "movie", creator: "the wizard of oz", publication_year: "2013", description: "abc")
      is_valid = work.valid?
      refute(is_valid)
    end
    
    it "is invalid if it does not have a unique title within its category" do
      work = Work.new(category: "book", title: "The best work ever", creator: "John Doe", description: "hello", publication_year: "2000")
      is_valid = work.valid?
      refute(is_valid)
    end
    
    it "is valid if it has the same title as a work of a different category" do
      work = Work.new(category: "album", title: "The best work ever", creator: "John Doe", description: "hello", publication_year: "2000")
      is_valid = work.valid?
      assert(is_valid)
    end
  end
  
  describe 'custom methods' do
    describe 'top_ten' do
      
      it "should return 10 elements if there are 10 or more works of the given category created" do
        top_books = Work.top_ten("book")
        expect(top_books.length).must_equal 10
      end 
      
      it "should return all works of a given category if there are less than 10 created" do
        Work.all.last.destroy
        Work.all.last.destroy
        top_books = Work.top_ten("book")
        expect(top_books.length).must_equal 9
      end
      
      it "should return an empty array if there are no works of the given category" do
        books = Work.where(category: "book")
        
        books.each do |book|
          book.destroy
        end
        
        expect(Work.all.length).must_equal 1
        
        top_books = Work.top_ten("book")
        expect(top_books).must_be_empty
      end
      
      it 'should return works in descending order by number of votes' do
        user = users(:valid_user)
        user_2 = users(:valid_user_2)
        valid_work = works(:valid_work_8)
        valid_work_2 = works(:valid_work_6)
        valid_work_3 = works(:valid_work_4)
        
        valid_work.upvote(user.id)
        valid_work_2.upvote(user.id)
        valid_work.upvote(user_2.id)
        
        expect(valid_work.votes.count).must_equal 2
        expect(valid_work_2.votes.count).must_equal 1
        expect(valid_work_3.votes.count).must_equal 0
        
        top_books = Work.top_ten("book")
        expect(top_books.first).must_equal valid_work
        expect(top_books[1]).must_equal valid_work_2
      end
      
    end
    
    describe 'spotlight' do
      it "should be an instance of Work" do
        spotlight = Work.spotlight
        expect(spotlight).must_be_instance_of Work
      end
      
      it 'should return the work with the most votes' do
        user = users(:valid_user)
        user_2 = users(:valid_user_2)
        valid_work = works(:valid_work_7)
        valid_work_2 = works(:valid_work_3)
        valid_work_3 = works(:valid_work_2)
        
        valid_work.upvote(user.id)
        valid_work_2.upvote(user.id)
        valid_work.upvote(user_2.id)
        
        expect(valid_work.votes.count).must_equal 2
        expect(valid_work_2.votes.count).must_equal 1
        expect(valid_work_3.votes.count).must_equal 0
        
        spotlight = Work.spotlight
        expect(spotlight).must_equal valid_work
      end
    end
    
    describe 'relationships' do
      it 'can have votes' do
        work = works(:valid_work)
        user = users(:valid_user)
        user_2 = users(:valid_user_2)
        
        vote_1 = Vote.create(user: user, work: work)
        vote_2 = Vote.create(user: user_2, work: work)
        
        expect(work.votes.count).must_equal 2
        expect(work.votes.first).must_be_instance_of Vote
      end
    end
    
    describe 'upvote' do
      before do
        @work = works(:valid_work)
        @user = users(:valid_user)
      end
      
      it 'should create an instance of Vote' do
        @work.upvote(@user.id)
        expect(@work.votes.first).must_be_instance_of Vote
      end
      
      it 'should increase the count of votes for a piece of work' do
        expect(@work.votes.count).must_equal 0
        @work.upvote(@user.id)
        expect(@work.votes.count).must_equal 1
      end
    end
  end
end