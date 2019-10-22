require "test_helper"


describe Vote do
  before do
    # Arrange
    
    @vote = Vote.new(user: users(:user3), work: works(:work1)) 
  end

  describe "validations" do
    it 'is valid when all fields are present' do
    # Act
      result = @vote.valid?
      # Assert
      expect(result).must_equal true
    end

    it "don't allow to vote more than once for the same work" do
      vote1 = Vote.create(work: works(:work1), user: users(:user1))
      vote1.save
      vote2 = Vote.new(work: works(:work1), user: users(:user1))
      result = vote2.valid?
      expect(result).must_equal false
    end

    it "needs a username(id)" do
      vote = Vote.new(work_id: @work)
      result = @vote.valid?
      expect(result).must_equal false
    end
  end

  describe 'relations' do 
    # Arrange
    it 'has works' do
      vote = Vote.first
      work = vote.work
      expect(work).must_be_instance_of Work
    end
  end
end
    
  



  
  



