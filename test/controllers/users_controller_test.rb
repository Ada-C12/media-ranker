require "test_helper"

describe UsersController do
  before do
    User.create!(name: "Rubber Duckie")
  end

  describe "current" do
    it "sets session[:user_id], redirects, and responds with success
    " do
      # Arrange
      user = perform_login

      # Act 
      get current_user_path

      # Assert 
      must_respond_with :success
    end

    it "sets flash[:error] and redirects when there's no user" do
      # Act 
      get current_user_path

      #Assert
      expect(flash[:error]).must_equal "You must be logged in to see this page"
      must_redirect_to root_path
    end
  end
end

