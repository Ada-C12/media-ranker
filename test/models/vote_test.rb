require "test_helper"

describe Vote do
  
  let (:yml) { let_yml_superhash }
  
  describe "RELATION" do
    let(:vote1m1) { yml[:vote1m1] }
    
    it "can only have 1 work obj" do 
      # not sure how else to test this...
      assert(vote1m1.work.class == Work)
      expect{vote1m1.work.count}.must_raise NoMethodError
    end
    
    it "can only have 1 user obj" do
      assert(vote1m1.user.class == User)
      expect{vote1m1.user.count}.must_raise NoMethodError
    end
    
    it "cannot have multiples of work & user combo (unique votes only)" do
      vote1m1
      # p vote1m1.user
      # p vote1m1.work
      # dup_vote = Vote.new(user: vote1m1.user, work: vote1m1.work)
      # p dup_vote.valid?
      # p dup_vote
      assert(false)
    end
    
    it "if its assoc'd work obj gets deleted, all votes dependent on it are now invalid" do
      work = vote1m1.work
      assert(work.votes.count == 4)
      
      work.destroy
      refute(Work.find_by(id: work.id))
      
      updated_vote = Vote.find_by(id: vote1m1.id)
      refute(updated_vote.valid?)
    end
    
    it "if its assoc'd user obj gets deleted, all votes dependent on it are now invalid" do
      single = yml[:vote1m10]
      sad = single.work
      p sad.votes.count
      
      user = vote1m1.user
      assert(user.votes.count == 13)
      
      user.destroy
      refute(User.find_by(id: user.id))
      
      updated_vote = Vote.find_by(id: vote1m1.id)
      refute(updated_vote.valid?) 
      
      p sad.votes.first

    end
  end
  
  describe "VALIDATION" do
    it "can create Vote obj with correct attributes" do
      any_democrat = Vote.new(user: User.first, work: Work.first)
      assert(any_democrat.save)
    end
    
    it "won't create Vote obj with bogus user_id" do
      anonymous_troll = Vote.new(user_id: nil, work: Work.first)
      refute(anonymous_troll.save)
      
      msgs = anonymous_troll.errors.messages
      assert(msgs.any?)
      assert(msgs.keys.include? :user)
      assert(msgs.values.include? ["must exist"])
    end
    
    it "won't create Vote obj with bogus work_id" do
      trump_prez_ballot = Vote.new(user_id: User.first, work: nil)
      refute(trump_prez_ballot.save)
      
      msgs = trump_prez_ballot.errors.messages
      assert(msgs.any?)
      assert(msgs.keys.include? :work)
      assert(msgs.values.include? ["must exist"])
    end
  end
  
  describe "CUSTOM METHODS" do
    # NONE USED
  end
  
end

