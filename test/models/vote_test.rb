require "test_helper"

describe Vote do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  let (:new_vote){
    vote = Vote.create!(work_id: @work.id, date: Time.now, user_id: @user.id)
  }

  describe 'relations' do
    it "can access the work for each vote" do

      expect(votes(:vote_1).work_id).must_equal works(:exmachina).id
    end 
  end

  describe "instantiations" do
    it "can be instantiated" do
      expect(new_vote.valid?).must_equal true
    end 
  end 

  describe "validations" do
    it "must have a work_id" do
      #Arrange
      new_vote.work_id = nil

      # fixture data does not run validations, so use the let value
      
      #Assert
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work

    end 
  end 
  
  describe "user_already_vote?" do
    it "prevents users from upvoting same work twice" do

      expect(Vote.user_already_vote?(works(:exmachina), users(:user_1))).must_equal false
    end
  end 
end
