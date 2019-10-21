require "test_helper"

describe User do
  describe "validations" do
    before do
      @kiki = users(:kiki)
    end
    it "is vaild when all fields are present" do
      assert(@kiki.valid?)
    end

    it "is invalid if username is blank" do
      @kiki.username = nil

      refute(@kiki.valid?)
    end
  end

  describe "relationships" do
    it "can set the Vote through votes" do
    vote = votes(:nouservote)
    bob = users(:bob)
  

    bob.votes << vote 

    expect(bob.votes.last.id).must_equal vote.id 
    

    end 
    it "can set the Vote with a collection " do
      votes= [votes(:nouservote)]
      bob = users(:bob)
  
      bob.votes = votes
  
      expect(bob.votes.last.id).must_equal votes.last.id
      
      end 
  

  end


end
