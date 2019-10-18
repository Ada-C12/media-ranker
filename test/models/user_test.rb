require "test_helper"

describe User do
  
  let (:user1) { users(:user1) }
  let (:db_user1) { User.find_by(name: user1.name) }
  let (:user2) { users(:user2) }
  let (:db_user2) { User.find_by(name: user2.name) }
  let (:album2) { works(:album2) }
  
  describe "RELATIONS" do
    it "can have many votes" do
      assert(db_user1.votes.count == 13)
      assert(db_user2.votes.count == 4)
    end
    
    it "userObj.votes exists and can return correct Vote objs" do
      votes_array = db_user2.votes
      votes_array.each do |vote|
        assert(vote.class == Vote)
        assert(vote.user_id == db_user2.id)
      end
    end
    
    it "if work_obj gets deleted, its dependent votes are too" do
      assert(false)
    end
  end
  
  describe "VALIDATIONS" do
    it "Can create User obj with correct attributes" do
      assert(user1.valid?)
      db_user1 = User.find_by(name: user1.name)
      assert(db_user1.name == user1.name)
      assert(db_user1.votes.count == 13)
      
      # make user1 cast a new valid vote
      vote1a2 = Vote.create(user_id: db_user1.id, work_id: album2.id)
      assert(db_user1.votes.count == 14)
      assert(db_user1.votes.last == Vote.last)
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
    # NONE USED
  end
  
end
