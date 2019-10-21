require "test_helper"

describe ApplicationController do
  
  describe "list_error_messages() for children: Users, Works, and Votes" do 
    # This is a parent method that all 3 children can call
    let(:users_ctrller) { UsersController.new }
    
    it "nominal case: list_error_messages() work?" do
      anonymous_troll = User.create(name:nil)
      result = users_ctrller.list_error_messages(anonymous_troll)
      assert(result == ["Name can't be blank"])
    end
    
    it "edge case: what if no errors to begin with?" do
      upstanding_citizen = User.create(name: "Caroline")
      expect{users_ctrller.list_error_messages(upstanding_citizen)}.must_raise ArgumentError      
    end
    
  end
  
end