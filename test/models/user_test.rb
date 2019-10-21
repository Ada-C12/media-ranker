require 'test_helper'

class UserTest < ActiveSupport::TestCase

  describe User do

    describe "validations" do

      it "can be valid" do
        is_valid = users(:valid_user_with_username).valid?
        assert( is_valid )
      end
  
      it "is invalid if there is no username" do
        user = users(:invalid_user_without_username)
        is_valid = user.valid?
        refute( is_valid )
      end
      
    end

  end
end
