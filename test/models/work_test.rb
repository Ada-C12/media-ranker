require "test_helper"

describe Work do
  let (:movie1) {works(:movie1)}
  let (:movie2) {works(:movie2)}

  it "shoud validiate a successful work" do 
    assert( movie1.valid? )
  end 

  it "should invalidate for an unsuccessful work if there is no title" do
    refute( movie2.valid? )
  end

  it "should have a vote (relationship test)" do
    vote = Vote.new(user_id:1, work_id:1)
    vote.work = movie1 
    expect(vote.work_id).must_equal movie1.id
  end 
end
