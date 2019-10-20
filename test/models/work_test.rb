require "test_helper"

describe Work do
  let (:movie1) {works(:movie1)}
  let (:movie2) {works(:movie2)}
  let (:vote1) {works(:vote1)}
  let (:vote2) {works(:vote2)}

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

  it "spotlight should retrieve the work with the most votes" do 
    expect(Work.spotlight.id).must_equal 2
    expect(Work.spotlight.votes.length).must_equal 3
  end 

  it "top_ten should return ten works" do 
    expect(Work.top_ten("movie").length).must_equal 10
  end 

  it "top_ten should return ten works of the same category" do 
    top_ten = Work.top_ten("movie")

    top_ten.each do |work|
      expect(work.category).must_equal "movie"
    end 
  end 

  it "should return works with higher vote counts" do 
    top_ten = Work.top_ten("movie")

    expect(top_ten.first.votes.length > top_ten.last.votes.length).must_equal true 
  end 
end
