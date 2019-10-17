require "test_helper"

describe User do
  it "can be instantiated" do
    expect(users(:new_user).valid?).must_equal true
  end

  it "will have the required fields" do
    users(:new_user).save
    expect(users(:new_user)).must_respond_to :username
  end


  describe "relationships" do
    it "can have many votes" do
      Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "upvote")
      Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "upvote")

      expect(users(:new_user).votes.count).must_equal 2
      users(:new_user).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      users(:new_user).username = nil

      expect(users(:new_user).valid?).must_equal false
      expect(users(:new_user).errors.messages).must_include :username
      expect(users(:new_user).errors.messages[:username]).must_include "can't be blank"
    end
    
    it "username must be between 1 and 25 characters" do
      invalid_user1 = User.create(username: "")
      invalid_user2 = User.create(username: "Here is a really long username.")

      expect(invalid_user1.valid?).must_equal false
      expect(invalid_user1.errors.messages).must_include :username
      expect(invalid_user1.errors.messages[:username]).must_include "is too short (minimum is 1 character)"
      
      expect(invalid_user2.valid?).must_equal false
      expect(invalid_user2.errors.messages).must_include :username
      expect(invalid_user2.errors.messages[:username]).must_include "is too long (maximum is 25 characters)"
    end
    
    describe "custom methods" do
      it 'self.username_by_id works correctly' do
      end
      it 'upvotes' do
      end
      it 'downvotes' do
      end
      it 'already_voted?' do
      end
    end
  
  
  end

end
