require "test_helper"

describe User do
  let (:new_user) {
    User.create(username: "testinguser")
  }

  describe "validations" do 
    it "can be instantiated" do 
      expect(new_user.valid?).must_equal true
    end 

    it "will have the required fields" do
      new_user.save
      user = User.first
      expect(user[:username]).must_equal "testinguser"
    end

end
