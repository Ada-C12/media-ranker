require 'test_helper'

class MediaTest < ActiveSupport::TestCase
  require "test_helper"
  
  describe Work do
    let (:new_work) {
    Work.new(category: "movie", title: "Mulan", creator: "disney", publication_year: 1990, description: "girl who loves books falls in love with prince")
  }
  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      
      # Assert
      expect(work).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      # Arrange
      new_work.save
      work = Work.first
      
      # Assert
      expect(work.votes.count).must_be :>=, 0
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
  
  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil
      
      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "must have a creator" do
      # Arrange
      new_work.creator = nil
      
      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :creator
      expect(new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end
  end
  
  describe "custom methods" do
    describe "works with max vote count" do
      before do
        @work = Work.create category: "movie", title: "Mulan", creator: "disney", publication_year: 1990, description: "girl who loves books falls in love with prince"
        @work_two = Work.create category: "book", title: "Angelina Ballerina", creator: "Shelia Walsh", publication_year: 2008, description: "mouse becomes ballerina"
        
        @user = User.create username: "muffin"
        @user_two = User.create username: "poppy"
        
        @vote_one = Vote.create user_id: @user.id, work_id: @work.id
        @vote_two = Vote.create user_id: @user_two.id, work_id: @work.id
        @vote_three = Vote.create user_id: @user.id, work_id: @work_two.id
      end
      
      it "must aggregate works with max vote count" do
        expect(Work.featured.id).must_equal @work.id
      end
    end
    
    # this is my edge case
    describe "works with no votes" do
      before do
      end
      
      it "must aggregate featured works with no votes" do
        Vote.destroy_all
        expect(Work.featured).must_equal nil
      end
    end
    
    describe "works that have been sorted to show top ten" do
      before do
        @work = Work.create category: "album", title: "Mulan", creator: "disney", publication_year: 1990, description: "girl who loves books falls in love with prince"
        @work_two = Work.create category: "album", title: "Angelina Ballerina", creator: "Shelia Walsh", publication_year: 2008, description: "mouse becomes ballerina"
        @work_three = Work.create category: "album", title: "Surfer Girl", creator: "Beach Boys", publication_year: 1963, description: "third studio album by the Beach Boys"
        
        @user = User.create username: "muffin"
        @user_two = User.create username: "poppy"
        
        @vote_one = Vote.create user_id: @user.id, work_id: @work.id
        @vote_two = Vote.create user_id: @user_two.id, work_id: @work.id
        @vote_three = Vote.create user_id: @user.id, work_id: @work_two.id
      end
      
      it "must sort works to show top ten based on votes" do
        sorted = Work.sort("album")
        expect(sorted[0].id).must_equal @work.id
        expect(sorted[1].id).must_equal @work_two.id
        expect(sorted[3].id).must_equal @work_three.id
      end
    end
  end
end
end
