require "test_helper"

describe UsersController do
  before do 
    User.create!(username:"yasmins")
  end
  
  describe "current" do
    it "sets session[:user_id], redirects, and responds with success" do
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


# describe "current" do
#   it "sets session[:user_id], redirects, and respond with success" do
#  # Arrange
#   user = preform_login
#   #Act
#   get current_user_path

#   #Assert
#    must_respond_with :success

#  login_data = {
#    user: {username: "yasmin"}
#   }
#    post login_path, params: login_data
#    get current_user_path
#    must_respond_with :success
# end
#   it "sets [flash:error] and redirect when there is no user" do
#     get current_user_path
#     expect (flash[:error]).must_equal "You must be logged in to see this page"
#   end 
# end
# end








