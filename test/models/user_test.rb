require "test_helper"

describe User do
  describe "validations" do 
    before do 
      # Arrange
      @user = User.create(username: "leaves2019")
      @bad_user = User.create(username: "")
    end
    
    it "must be valid" do 
      # Act
      result = @user.valid?
      
      # Assert
      expect(result).must_equal true
    end
    
    it "is invalid without a username" do 
      # Act
      bad_result = @bad_user.valid?
      
      # Assert
      expect(bad_result).must_equal false
    end
  end
  
  describe "relationships" do 
    before do 
      # Arrange
      @user = User.create(username: "hello_world")
      @movie = Work.create(category: "movie", title: "Nightmare Before Chirstmas", creator: "Tim Burton", publication_year: 1993, description: "Jack Skellington tries to bring Christmas magic to Halloween Town. Chaos ensues.")
      @movie2 = Work.create(category: "movie", title: "Hocus Pocus", creator: "Fox", publication_year: 1993, description: "Super spooky.")
      @vote = Vote.create(user_id: @user.id, work_id: @movie.id)
      @vote2 = Vote.create(user_id: @user.id, work_id: @movie2.id)
    end
    
    it "can have many votes" do 
      expect(@user.votes.length).must_equal 2
      expect(@user.votes[0]).must_be_kind_of Vote
    end
  end
end
