require "test_helper"

describe User do
  
  let (:user1) { users(:user1) }
  let (:album2) { works(:album2) }
  
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
      db_user = User.find_by(name: user1.name)
      assert(db_user.name == user1.name)
      assert(db_user.votes.count == 13)
      
      # make user1 cast a new valid vote
      vote1a2 = Vote.create(user_id: db_user.id, work_id: album2.id)
      assert(db_user.votes.count == 14)
      assert(db_user.votes.last == Vote.last)
    end
    
    it "Won't create User obj, given blank name inputs" do
      bad_args = ["", nil, "   "]
      bad_args.each do |bad_arg|
        bogus1 = User.new(name: bad_arg)
        refute(bogus1.save)
        expect(bogus1.errors.messages.keys).must_include :name
        expect(bogus1.errors.messages.values).must_include ["can't be blank"]
      end
    end
    
    it "Won't create User obj, given copycat name inputs" do
      user1
      db_user = User.find_by(name: user1.name)
      assert(db_user.name == "Lisa Simpson")
      
      evil_twin = User.new(name: "Lisa Simpson")
      refute(evil_twin.save)
      expect(evil_twin.errors.messages.keys).must_include :name
      expect(evil_twin.errors.messages.values).must_include ["has already been taken"]
    end
  end
  
  
  describe "CUSTOM METHOD #1" do
    it "nominal case" do
    end
    
    it "edge case" do
    end
  end
  
end
