require "test_helper"

describe User do
  let (:user1) {users(:user1)}
  let (:user2) {users(:user2)}

  it "shoud validiate a successful work" do 
    assert( user1.valid? )
  end 

  it "should invalidate for an unsuccessful work if there is no title" do
    refute( user2.valid? )
  end

  it "should have vote (relationship test)" do 
  end 
end
