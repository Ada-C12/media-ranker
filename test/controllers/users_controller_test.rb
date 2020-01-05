require "test_helper"

describe UsersController do
  describe "current" do  
    before do
      User.create!(username: "georgina")
    end  

    it "returns 302:found for a logged-in user" do
      # Arrange
      perform_login

      # Act
      get current_user_path

      # Assert
      must_respond_with :found
    end


  end
end
