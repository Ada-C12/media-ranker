require "test_helper"

describe UsersController do
  it "responds with not_found when user hasn't logged in" do
    get current_user_path
    
    must_respond_with :not_found
  end
  
  it "responds with success when user has logged in" do
    user = User.first
    params = {
      user: {
        username: user.username
      }
    }
    puts "user info:"
    
    p user 
    post login_path(params)
    
    #TO-DO intial code user_id my model is just id
    expect(session[:user_id]).must_equal user.id
    
    puts "test:"
    p expect(session[:user_id]).must_equal user.id
    get current_user_path
    p user
    p current_user_path
    must_respond_with :success
  end
end