require "test_helper"

describe User do
  # failure case for current action in user
  # it "sets flash[:error] and redirects when there's no uer" do
  #   get current_user_path
  
  #   expect(flash[:error]).must_equal "You must be logged in to see this page"
  #   must_redirect_to root_path
  # end 

  # putting the login in the test helper, means you can access it before each test across the application.
# Then call the method from the test helper.
# that helper method is testing the login, so ur good on testing the login.
# it tests a nominal success case.

let (:new_user) {
  User.create!(username: "blueberry", joined: Time.now)
}

  describe 'relations' do
    it "can access the votes for each user" do
    
      vote = Vote.create!(work_id: @work.id, date: Time.now, user_id: @user.id)
      print @work.id
      print @user.id

      expect(@user.votes.count).must_equal 1
    end 
  end

  describe "instantiations" do
    it "can be instantiated" do
      expect(@user.valid?).must_equal true
    end 
  end 

  describe "validations" do
    it "must have a username" do
      #Arrange
      new_user.username = nil

      # fixture data does not run validations, so use the let value
      
      #Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end 

    it "must have a unique title" do
      new_user
      new_user2 = User.new(username: "blueberry", joined: Time.now)
      
      expect(new_user2.valid?).must_equal false
    end 
  end 

end
