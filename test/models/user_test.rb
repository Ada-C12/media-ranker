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
end
