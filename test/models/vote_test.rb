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
      # I didn't have this as part of Model's job, my ctrller did this part instead
    end
    
    it "if its assoc'd work obj gets deleted, votes are not gone" do
      # just because a candidate died while running for office, doesn't mean the vote ain't legit
      before = Vote.count
      work = vote1m1.work
      work.destroy
      refute(Work.find_by(id: work.id))
      
      # the only thing the vote obj is affected by should be the work attrib
      # but it remains in the Vote database
      updated_vote = Vote.find_by(id: vote1m1.id)
      assert(updated_vote.work == nil)
      assert(Vote.count == before)
    end
    
    it "if its assoc'd user obj gets deleted, votes are not gone" do
      # just because a voter died after voting, doesn't mean the vote ain't legit
      before = Vote.count
      user = vote1m1.user
      user.destroy
      refute(User.find_by(id: user.id))
      
      # the only thing the vote obj is affected by should be the work attrib
      # but it remains in the Vote database
      updated_vote = Vote.find_by(id: vote1m1.id)
      assert(updated_vote.user == nil)
      assert(Vote.count == before)
    end
  end
  
  describe "VALIDATION" do
    it "can create Vote obj with correct attributes" do
      any_democrat = Vote.new(user: User.first, work: Work.first)
      assert(any_democrat.save)
    end
    
    it "won't create Vote obj with bogus user" do
      anonymous_troll = Vote.new(user: nil, work: Work.first)
      refute(anonymous_troll.save)
      
      msgs = anonymous_troll.errors.messages
      assert(msgs.any?)
      assert(msgs.keys.include? :user)
      assert(msgs.values.include? ["must exist"])
    end
    
    it "won't create Vote obj with bogus work" do
      trump_prez_ballot = Vote.new(user: User.first, work: nil)
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

