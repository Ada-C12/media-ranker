require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe User do
    let (:new_user) {
    new_user = User.new(username: "muffin")
  }
  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_user.save
    user = User.first
    [:username].each do |field|
      
      # Assert
      expect(user).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      # Arrange
      new_user.save
      user = User.first
      
      # Assert
      expect(user.votes.count).must_be :>=, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
  
  describe "validations" do
    it "must have a username" do
      # Arrange
      new_user.username = nil
      
      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
  
  describe "custom methods" do
    describe "user with works by user" do
      before do
        @work = Work.create category: "movie", title: "Mulan", creator: "disney", publication_year: 1990, description: "girl who loves books falls in love with prince"
        @work_two = Work.create category: "book", title: "Angelina Ballerina", creator: "Shelia Walsh", publication_year: 2008, description: "mouse becomes ballerina"
        
        @user = User.create username: "muffin"
        @user_two = User.create username: "poppy"
        
        @vote_one = Vote.create user_id: @user.id, work_id: @work.id
        @vote_two = Vote.create user_id: @user_two.id, work_id: @work.id
        @vote_three = Vote.create user_id: @user.id, work_id: @work_two.id
      end
      
      it "shows works voted by specific user" do
        works = @user.works_by_user
        expect(works[0].id).must_equal @work.id
        expect(works[1].id).must_equal @work_two.id
      end
    end
    
  end
end
end