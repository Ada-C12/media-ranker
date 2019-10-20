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

  it "needs a username(id)"
    vote = Vote.new(work_id: @work)
    result = @vote.valid?
    expect(result).must_equal false
    expect(vote.errors.messages).must_equal ["user has to login to vote"]
  end
  
    describe 'relations' do 
      before do 
      # Arrange
      it 'has works' do
      vote = Vote.first
      workss = vote.works
      works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end
      
    


 
   
   



