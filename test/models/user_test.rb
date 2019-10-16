require "test_helper"

describe User do
  
  let (:user1) { users(:user1) }
  
  describe "RELATIONS" do
    it "can have many votes" do
      ### NEED Votes Model
    end
    
    it "userObj.votes exists and can return Vote objs" do
      
    end
  end
  
  
  describe "VALIDATIONS" do
    it "Can create User obj, given good inputs" do
      assert(user1.valid?)
    end
    
    it "Won't create User obj, given bogus inputs" do
      refute()
      # expect (@test_object.erors.messages).must_include :attrib_name
      # assert (@test_object.errors.messages.attrib_name == "expected error string")
    end
  end
  
  
  
  describe "CUSTOM METHOD #1" do
    it "nominal case" do
    end
    
    it "edge case" do
    end
  end
  
end
