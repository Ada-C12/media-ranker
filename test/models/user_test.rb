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
    vote = Vote.new(user_id:1, work_id:1)
    vote.user = user1
    expect(vote.user_id).must_equal user1.id
  end 

  it "should validate if a username is already in the database or not" do 
    
  end 
end
