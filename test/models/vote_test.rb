require "test_helper"

describe Vote do
  
  it "can be instantiated" do
    vote = votes(:one)
    expect(vote.valid?).must_equal true
  end

  it "has the required fields" do 
    vote = votes(:one)
    [:date, :work_id, :user_id].each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe "relations" do 
    it "belongs to a user" do 
      user = users(:allison)
      vote = user.votes.first
      expect(vote.valid?).must_equal true
    end
    it "belongs to a work" do 
      work = works(:rent)
      vote = work.votes.last
      expect(vote.valid?).must_equal true
    end
  end 
end
