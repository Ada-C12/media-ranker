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
  
  describe "relationships" do 
    before do 
      @user = User.create(username: "hello_world")
      @user2 = User.create(username: "goodmorning world!")
      @movie = Work.create(category: "movie", title: "Nightmare Before Chirstmas", creator: "Tim Burton", publication_year: 1993, description: "Jack Skellington tries to bring Christmas magic to Halloween Town. Chaos ensues.")
      @vote = Vote.create(user_id: @user.id, work_id: @movie.id)
      @vote2 = Vote.create(user_id: @user2.id, work_id: @movie.id)
    end
    
    it "belongs to a user" do 
      expect(@vote.user).must_equal @user
      expect(@vote.user).must_be_kind_of User
    end
    
    it "belongs to a work" do 
      expect(@vote.work).must_equal @movie
      expect(@vote.work).must_be_kind_of Work
    end
  end
end
