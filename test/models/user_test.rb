require "test_helper"

describe User do
  it "can be instantiated" do
    assert(users(:new_user).valid?)
  end

  it "will have the required fields" do
    users(:new_user).save
    expect(users(:new_user)).must_respond_to :username
  end


  describe "relationships" do
    before do
      @new_work2 = Work.create(category: "book", title: "Cool Book2", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0
      )
      @new_work3 = Work.create(category: "book", title: "Cool Book3", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0
      )
    end

    it "can have many votes" do
      Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "upvote")
      Vote.create(work_id: @new_work2.id, user_id: users(:new_user).id, vote_type: "upvote")

      expect(users(:new_user).votes.count).must_equal 2
      users(:new_user).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      users(:new_user).username = nil

      refute(users(:new_user).valid?)
      expect(users(:new_user).errors.messages).must_include :username
      expect(users(:new_user).errors.messages[:username]).must_include "can't be blank"
    end
    
    it "username must be between 1 and 25 characters" do
      invalid_user1 = User.create(username: "")
      invalid_user2 = User.create(username: "Here is a really long username.")

      refute(invalid_user1.valid?)
      expect(invalid_user1.errors.messages).must_include :username
      expect(invalid_user1.errors.messages[:username]).must_include "is too short (minimum is 1 character)"
      
      refute(invalid_user2.valid?)
      expect(invalid_user2.errors.messages).must_include :username
      expect(invalid_user2.errors.messages[:username]).must_include "is too long (maximum is 25 characters)"
    end
    
    describe "custom methods" do
      describe 'self.username_by_id' do
        it 'returns user name when given id successfully' do
          new_user_id = users(:new_user).id  
          expect(User.username_by_id(new_user_id)).must_equal "Emily"
        end

        it 'returns nil if no user' do
          assert_nil(User.username_by_id(-1))
        end
      end

      describe 'upvotes' do
        before do
          @new_work2 = Work.create(category: "book", title: "Cool Book2", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0
          )
          @new_work3 = Work.create(category: "book", title: "Cool Book3", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0
          )
        end

        it 'returns upvotes for given user - ignores downvotes' do
          new_user = users(:new_user) 
          Vote.create(work_id: works(:new_work).id, user_id: new_user.id, vote_type: "upvote")
          expect(new_user.upvotes.count).must_equal 1
          
          Vote.create(work_id: @new_work2.id, user_id: new_user.id, vote_type: "upvote")
          expect(new_user.upvotes.count).must_equal 2

          Vote.create(work_id: @new_work2.id, user_id: new_user.id, vote_type: "downvote")
          expect(new_user.upvotes.count).must_equal 2
        end

        it 'returns nil if no votes' do
          new_user = users(:new_user) 
          assert_nil(new_user.upvotes)
        end

        it 'returns [] if no upvotes (but there are downvotes)' do
          new_user = users(:new_user) 
          Vote.create(work_id: works(:new_work).id, user_id: new_user.id, vote_type: "downvote")
          expect(new_user.votes.count).must_equal 1
          expect(new_user.upvotes).must_equal []
        end
      end

      describe 'downvotes' do
        before do
          @new_work2 = Work.create(category: "book", title: "Cool Book2", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0
          )
          @new_work3 = Work.create(category: "book", title: "Cool Book3", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0
          )
        end

        it 'returns downvotes for given user - ignores upvotes' do
          new_user = users(:new_user) 
          Vote.create(work_id: works(:new_work).id, user_id: new_user.id, vote_type: "downvote")
          expect(new_user.downvotes.count).must_equal 1
          
          Vote.create(work_id: @new_work2.id, user_id: new_user.id, vote_type: "downvote")
          expect(new_user.downvotes.count).must_equal 2

          Vote.create(work_id: @new_work3.id, user_id: new_user.id, vote_type: "upvote")
          expect(new_user.downvotes.count).must_equal 2
        end

        it 'returns nil if no votes' do
          new_user = users(:new_user) 
          assert_nil(new_user.downvotes)
        end

        it 'returns [] if no downvotes (but there are upvotes)' do
          new_user = users(:new_user) 
          Vote.create(work_id: works(:new_work).id, user_id: new_user.id, vote_type: "upvote")
          expect(new_user.votes.count).must_equal 1
          expect(new_user.downvotes).must_equal []
        end
      end

      describe 'already_voted?' do
        it 'returns true if user has already voted on given work_id (vote_type does not matter)' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "upvote") 
          
          assert(new_user.already_voted?(new_work.id))
        end
        
        it 'returns false if user has not already voted on given work_id (vote_type does not matter)' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "upvote")
          new_work2 = Work.create(category: "album", title: "Dogs", creator: "Animals", description: "Here is a desc", publication_year: 1993, vote_count: 0)
          
          refute(new_user.already_voted?(new_work2.id))
        end
        
        it 'returns nil if given work doesnt exist' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "upvote") 
          
          assert_nil(new_user.already_voted?(-1))
        end

        it 'returns false if user has no votes' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          
          refute(new_user.already_voted?(new_work.id))
        end
      end
    
      describe 'already_upvoted?' do
        it 'returns true if user has already upvoted given work_id' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "upvote") 
          
          assert(new_user.already_upvoted?(new_work.id))
        end
        
        it 'returns false if user has not already upvoted given work_id' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "downvote")
          
          refute(new_user.already_upvoted?(new_work.id))
        end
        
        it 'returns nil if given work doesnt exist' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "upvote") 
          
          assert_nil(new_user.already_upvoted?(-1))
        end

        it 'returns false if user has no votes' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          
          refute(new_user.already_upvoted?(new_work.id))
        end
      end

      describe 'already_downvoted?' do
        it 'returns true if user has already downvoted given work_id' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "downvote") 
          
          assert(new_user.already_downvoted?(new_work.id))
        end
        
        it 'returns false if user has not already downvoted given work_id' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "upvote")
          
          refute(new_user.already_downvoted?(new_work.id))
        end
        
        it 'returns nil if given work doesnt exist' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          Vote.create(work_id: new_work.id, user_id: new_user.id, vote_type: "downvote") 
          
          assert_nil(new_user.already_downvoted?(-1))
        end

        it 'returns false if user has no votes' do
          new_user = users(:new_user)
          new_work = works(:new_work)
          
          refute(new_user.already_downvoted?(new_work.id))
        end
      end    

    end
  end
end
