require "test_helper"

describe User do
  describe "validations" do
    it "can create a new user for valid input" do
      is_valid = users(:user1).valid?
      assert(is_valid)
    end
    
    it "is invalid if there is no username" do
      invalid_usernames = [nil, "", "    "]
      invalid_usernames.each do |invalid_username|
        user = User.create(username: invalid_username)
        
        is_valid = user.valid?
        
        refute( is_valid )
      end
    end
    
    it "is invalid if there exists another user on DB that has the same username" do
      existing_user = users(:user1)
      is_valid = existing_user.valid?
      assert(is_valid)
      
      new_user = User.create(username: existing_user.username)
      refute( new_user.valid?)
    end

  end

  describe "relationships" do
    it 'can have many votes for different works' do
      valid_user = users(:user1)
      total_votes = valid_user.votes.length
      valid_works = [works(:album1), works(:album2), works(:album3)]
      expect (total_votes).must_equal 0
    
      valid_works.each do |work|
        vote = Vote.create(user_id: valid_user.id, work_id: work.id)  

        expect _(User.find_by(id: valid_user.id).votes.length).must_equal (total_votes + 1)
        assert(User.find_by(id: valid_user.id).votes.include?(vote))
        total_votes += 1
      end
    end

    it "if user is deleted, all votes belong the user should be remove" do
      valid_user = users(:user1)
      valid_works = [works(:album1), works(:album2), works(:album3)]
    
      valid_works.each do |work|
        Vote.create(user_id: valid_user.id, work_id: work.id)  
      end
      expect (Vote.count).must_equal valid_works.length

      valid_user.destroy
      expect (Vote.count).must_equal 0
    end
  end
end
