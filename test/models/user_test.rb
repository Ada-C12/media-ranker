require "test_helper"

describe User do
  let (:new_work) {
    Work.create(category: "book", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc", publication_year: 1993, vote_count: 0)
  }
  let (:new_user) {
    User.create(username: "Emily")
  }
  
  it "can be instantiated" do
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    new_user.save
    expect(new_user).must_respond_to :username
  end


  describe "relationships" do
    it "can have many votes" do
      Vote.create(work_id: new_work.id, user_id: new_user.id)
      Vote.create(work_id: new_work.id, user_id: new_user.id)

      expect(new_user.votes.count).must_equal 2
      new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      new_user.username = nil

      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_include "can't be blank"
    end
    
    it "username must be between 1 and 25 characters" do
      new_user1 = User.create(username: "")
      new_user2 = User.create(username: "Here is a really long username.")

      expect(new_user1.valid?).must_equal false
      expect(new_user1.errors.messages).must_include :username
      expect(new_user1.errors.messages[:username]).must_include "is too short (minimum is 1 character)"
      
      expect(new_user2.valid?).must_equal false
      expect(new_user2.errors.messages).must_include :username
      expect(new_user2.errors.messages[:username]).must_include "is too long (maximum is 25 characters)"
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
