require "test_helper"

describe User do
  let (:text_user) {
    User.new(name: 'SpongeBob')
  }
  
  describe "initilaiztaion" do
    it "can be instantiated" do
      expect(text_user.valid?).must_equal true
    end
  end 

  describe "validations" do 
    it "must have a name" do
      text_user.name = nil

      expect(text_user.valid?).must_equal false
      expect(text_user.errors.messages).must_include :name
      expect(text_user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end
end
