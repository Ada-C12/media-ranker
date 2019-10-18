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

  it "user adds new work correctly, should be successful" do
    # new_work = {
    #   work: {
    #     category:"movie", 
    #     title:"Howl's Moving Castle", 
    #     creator:"Hayao Miyazaki", 
    #     publication_year:2010, 
    #     description:"Girl turns into an old woman"
    #   }
    # }
    
    # expect{post works_path, params: new_work}.must_differ "Work.count", 1
  end

  it "user adds new work incorrectly, should be unsuccessful" do
  end

  it "should set a vote (relationship test)" do
  end 
  
end
