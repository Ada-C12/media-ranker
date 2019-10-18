require "test_helper"

describe User do
  let (:new_user) {
    User.new(
      username: "Mochi Cat"
    )
  }
  
  describe "validations" do
    it "can create a valid user" do
      expect(new_user.save).must_equal true
    end
    
    it "will have the required fields" do
      new_user.save
      user = User.last
      
      expect(user).must_respond_to :username
    end
    
    it "cannot create a user without an username" do
      new_user.username = nil
      
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
  
  describe "custom methods" do
    describe "self.is_logged_in" do
      it "returns false when session id is nil" do
        session_id = nil
        
        expect(User.is_logged_in(session_id)).must_equal false
      end
      
      it "returns false when no User found with user id corresponding to session id" do
        session_id = -1
        
        expect(User.is_logged_in(session_id)).must_equal false
      end
      
      it "returns true when session id is valid" do
        new_user.save 
        expect(User.first).wont_be_nil
        
        session_id = User.first.id
        
        expect(User.is_logged_in(session_id)).must_equal true
      end
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      expect(users(:doug).votes.count).must_be :>, 1
      
      users(:doug).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
