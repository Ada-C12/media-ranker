require "test_helper"

describe User do
  
  let (:user1) { users(:user1) }
  
  describe "RELATIONS" do
    it "can have many votes" do
      ### NEED Votes Model
    end
    
    it "userObj.votes exists and can return Vote objs" do
      ### NEED Votes Model
    end
  end
  
  describe "VALIDATIONS" do
    it "Can create User obj with correct attributes" do
      assert(user1.valid?)
      user1.save!
      db_user = User.first
      assert(db_user.name == user1.name)
      assert(db_user.votes_casted == 0)
      # assert(db_user.votes.count == 0)
      
      # make user1 cast a vote
      # assert(db_user.votes_casted == 1)
      # assert(db_user.votes.count == 1)
    end
    
    it "Won't create User obj, given bogus inputs" do
      bad_args = ["", nil, "   "]
      bad_args.each do |bad_arg|
        bogus1 = User.new(name: bad_arg)
        attempt = bogus1.save
        refute(attempt)
        expect (attempt.errors.messages).must_include :name
        assert (attempt.errors.messages.attrib_name == "expected error string")
      end
    end
  end
  
  
  
  describe "CUSTOM METHOD #1" do
    it "nominal case" do
    end
    
    it "edge case" do
    end
  end
  
end
