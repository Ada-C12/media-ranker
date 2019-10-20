require "test_helper"

class VoteTest < ActiveSupport::TestCase
  describe Vote do
    before do
      # Arrange
      @vote = Vote.new(username:'bob', work_id: 2)
    end
    describe "validations" do
    
    it 'is valid when all fields are present' do
      # Act
      result = @vote.valid?
      # Assert
      expect(result).must_equal true
    end

    it "don't allow to vote more than once for the same work"
    vote1 = Vote.create(work: work, user: user)
    vote1.save
    vote2 = Vote.new(work: work, user:user)
    result = vote2.valid?
    expect(result).must_equal false
  end

    describe 'relations' do 
      before do 
      # Arrange
      @user = User.new(:username)
      @work = Work.new(:work)
      @vote = Vote.new(username: @username, )

    it 'has votes' do
      work = Work.first
      user = User.votes
      
    end


  end

 
   
   



