require "test_helper"

describe User do
  
  let (:yml) { let_yml_superhash }
  let (:user1) { yml[:user1] }
  let (:user2) { yml[:user2] }
  let (:movie1) { yml[:movie1] }
  
  describe "RELATIONS" do
    it "can have many votes" do
      assert(user1.votes.count == 13)
      assert(user2.votes.count == 4)
      
      [user1, user2].each do |user_instance|
        user_instance.votes.each do |vote|
          assert(vote.class == Vote)
        end
      end
    end
    
    it "can add votes" do
      assert(user1.votes.count == 13)
      new_vote = Vote.create(work: movie1, user_id: user1.id)
      assert(user1.votes.count == 14)
    end
    
    it "user_obj.votes exists and can return correct Vote objs" do
      votes_array = user2.votes
      votes_array.each do |vote|
        assert(vote.class == Vote)
        assert(vote.user_id == user2.id)
      end
    end
    
    it "if work_obj gets deleted, its dependent votes are too" do
      assert(user2.votes.count == 4)
      
      user2.destroy 
      refute(User.find_by(name: user2.name))
      
      assert(user2.votes.count == 0)
      # what happens to the votes themselves? We're testing that in vote_test.rb
    end
  end
  
  describe "VALIDATIONS" do
    it "Can create User obj with correct attributes" do
      assert(User.create(name: "Ned Flanders"))
      new_user = User.last
      assert(new_user.name == "Ned Flanders")
      assert(new_user.votes.count == 0)
      
      # make new_user cast a new valid vote
      Vote.create!(user_id: new_user.id, work_id: movie1.id)
      assert(new_user.votes.count == 1)
      assert(new_user.votes.last == Vote.last)
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
