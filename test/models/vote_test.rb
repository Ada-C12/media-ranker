require "test_helper"

describe Vote do
  describe "validations" do
    it "can be valid" do
      valid_user = users(:user1)
      valid_work = works(:album1)
      is_valid = Vote.create(user_id: valid_user.id, work_id: valid_work.id).valid?

      assert( is_valid )
    end

    it "is invalid if user_id or work_id is invalid" do
      refute( Vote.create(user_id: -1, work_id: works(:album1).id).valid? )
      refute( Vote.create(user_id: users(:user1), work_id: -1).valid?)
      refute( Vote.create(user_id: users(:user1)).valid?)
      refute( Vote.create(work_id: works(:album1).id).valid?)
    end
  end

  describe "relationships" do

    it 'can set the user and work through .user and .work' do
      valid_user = users(:user1)
      valid_work = works(:album1)
      vote = Vote.new()

      vote.user = valid_user
      vote.work = valid_work

      expect( vote.user_id ).must_equal valid_user.id
      expect( vote.work_id ).must_equal valid_work.id
    end

    it 'can set the user and work through user_id and work_id' do
      valid_user = users(:user1)
      valid_work = works(:album1)
      vote = Vote.new()

      vote.user_id = valid_user.id
      vote.work_id = valid_work.id

      expect( vote.user ).must_equal valid_user
      expect( vote.work ).must_equal valid_work
    end
  end

  describe "create_vote method" do
    it "returns a new vote for valid user ID and work ID" do 
      valid_user = User.first
      valid_work = Work.first

      valid_vote = Vote.create_vote(user_id: valid_user.id, work_id: valid_work.id)
      assert (valid_vote.valid?)
    end
    
    it "doesn't create a new valid vote and returns nil for invalid user ID and work ID" do 
      valid_user = User.first
      valid_work = Work.first

      invalid_vote1 = Vote.create_vote(user_id: -1, work_id: valid_work.id)
      refute (invalid_vote1)

      invalid_vote2 = Vote.create_vote(user_id: valid_user.id, work_id: -1)
      refute (invalid_vote2)
    end
    
    it "user can only vote for work once" do
      valid_user = User.first
      valid_work = Work.first
      
      valid_vote = Vote.create_vote(user_id: valid_user.id, work_id: valid_work.id)
      assert (valid_vote.valid?)
      assert (valid_vote.save)

      in_valid_vote = Vote.create_vote(user_id: valid_user.id, work_id: valid_work.id)
      refute (in_valid_vote.save)
    end
  end
end
