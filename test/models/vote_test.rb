require "test_helper"

describe Vote do
  describe "validations" do 
    before do 
      @user = User.create(username: "hello_world")
      @work = Work.create(category: "book", title: "Ada Dev Academy", creator: "The whole gang", publication_year: 2015, description: "great stuff")
      @vote = Vote.create(user_id: @user.id, work_id: @work.id)
      @bad_vote = Vote.create(user_id: @user.id, work_id: @work.id )
    end
    
    # Act 
    it "is valid when all fields are present" do
      result = @vote.valid? 
      
      # Assert
      expect(result).must_equal true
    end
    
    it "is invalid without a user_id" do 
      # Arrange
      vote = Vote.create(user_id: "", work_id: @work.id)
      
      # Act
      result = vote.valid?
      
      # Assert
      expect(result).must_equal false
    end
    
    it "does not allow a user to vote on a work more than once" do 
      # Act 
      result = @bad_vote.valid?
      
      # Assert
      expect(result).must_equal false
    end
    
    it "is not valid without a work_id" do 
      # Arrange
      vote = Vote.create(user_id: @user.id, work_id: "")
      
      # Act
      result = vote.valid? 
      
      #Assert
      expect(result).must_equal false
    end
    
  end
end
