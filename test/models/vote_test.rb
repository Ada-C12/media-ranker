require "test_helper"

describe Vote do
  let (:new_vote) {
    Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "upvote")
  }
  
  let (:new_work2) {
    Work.create(category: "book", title: "Cool Book2", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0)
  }

  let (:new_work3) {
    Work.create(category: "book", title: "Cool Book3", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0)
  }

  let (:new_work4) {
    Work.create(category: "book", title: "Cool Book4", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0)
  }

  it "can be instantiated" do
    assert(new_vote.valid?)
  end

  it "will have the required fields" do
    new_vote.save
    [:work_id, :user_id].each do |field|
      expect(new_vote).must_respond_to field
    end
  
  end

  describe "relationships" do
    
    it "can have one work" do
      expect(new_vote.work).must_be_instance_of Work
      expect(new_vote.work.title).must_equal "Cool Book"
    end

    it "can have one user" do
      expect(new_vote.user).must_be_instance_of User
      expect(new_vote.user.username).must_equal "Emily"
    end
  
  end

  describe "validations" do
    
    it "must have a work_id" do
      new_vote.work_id = nil

      refute(new_vote.valid?)
      expect(new_vote.errors.messages).must_include :work_id
      expect(new_vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end
    
    it "must have a user_id" do
      new_vote.user_id = nil

      refute(new_vote.valid?)
      expect(new_vote.errors.messages).must_include :user_id
      expect(new_vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end
  
    it "must have a vote_type" do
      new_vote.vote_type = nil

      refute(new_vote.valid?)
      expect(new_vote.errors.messages).must_include :vote_type
      expect(new_vote.errors.messages[:vote_type]).must_equal ["can't be blank"]
    end

    it "must have a unique user_id in the score of the work_id" do
      new_vote.save
      new_vote2 = Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "upvote")
      refute(new_vote2.valid?)
    end
    
  end

  describe "custom methods" do
    
    describe 'self.all_upvotes' do
      it 'returns all upvotes correctly - ignore downvotes' do
        new_vote.save
        upvotes = Vote.all_upvotes
        expect(upvotes.count).must_equal 1
        
        Vote.create(work_id: new_work2.id, user_id: users(:new_user).id, vote_type: "upvote")
        upvotes = Vote.all_upvotes
        expect(upvotes.count).must_equal 2
        
        Vote.create(work_id: new_work3.id, user_id: users(:new_user).id, vote_type: "upvote")
        upvotes = Vote.all_upvotes
        expect(upvotes.count).must_equal 3

        Vote.create(work_id: new_work4.id, user_id: users(:new_user).id, vote_type: "downvote")
        upvotes = Vote.all_upvotes
        expect(upvotes.count).must_equal 3
      end

      it 'returns nil if no votes' do
        Vote.destroy_all
        assert_nil(Vote.all_upvotes)
      end

      it 'returns [] if no upvotes (but there are downvotes)' do
        Vote.destroy_all
        Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "downvote")
        
        expect(Vote.all_upvotes).must_equal []
      end
    end
    
    describe 'self.all_downvotes' do
      it 'returns all downvotes correctly - ignore upvotes' do
        new_vote.save
        downvotes = Vote.all_downvotes
        expect(downvotes.count).must_equal 0
        
        Vote.create(work_id: new_work2.id, user_id: users(:new_user).id, vote_type: "downvote")
        downvotes = Vote.all_downvotes
        expect(downvotes.count).must_equal 1
        
        Vote.create(work_id: new_work3.id, user_id: users(:new_user).id, vote_type: "downvote")
        downvotes = Vote.all_downvotes
        expect(downvotes.count).must_equal 2

        Vote.create(work_id: new_work4.id, user_id: users(:new_user).id, vote_type: "upvote")
        downvotes = Vote.all_downvotes
        expect(downvotes.count).must_equal 2
      end
    
      it 'returns nil if no votes' do
        Vote.destroy_all
        assert_nil(Vote.all_downvotes)
      end

      it 'returns [] if no upvotes (but there are downvotes)' do
        Vote.destroy_all
        Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "upvote")
        
        expect(Vote.all_downvotes).must_equal []
      end
    end
  
    describe 'find_vote' do
      it 'finds vote given work_id and user_id' do
        vote = new_vote
        new_work = works(:new_work)
        new_user = users(:new_user)
        found_vote = Vote.find_vote(user_id: new_user, work_id: new_work)
        expect(vote.id).must_equal found_vote.id
      end
      
      it 'returns nil if given invalid user or work id' do
        vote = new_vote
        new_work = works(:new_work)
        new_user = users(:new_user)
        
        found_vote = Vote.find_vote(user_id: -1, work_id: new_work)
        assert_nil(found_vote)
        
        found_vote2 = Vote.find_vote(user_id: new_user, work_id: -1)
        assert_nil(found_vote2)
      end
    
      it 'returns [] if no vote exists given user/work id combo' do
        Vote.destroy_all
        new_work = works(:new_work)
        new_user = users(:new_user)
        
        found_vote = Vote.find_vote(user_id: new_user, work_id: new_work)
        expect(found_vote).must_equal []
      end
    end
  end
end
