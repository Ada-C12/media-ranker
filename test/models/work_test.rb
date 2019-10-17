require "test_helper"

describe Work do
  let (:movie1) {works(:movie1)}
  let (:movie2) {works(:movie2)}

  it "shoud validiate a successful work" do 
    is_valid = movie1.valid?
  
    assert( is_valid )
  end 

  it "should invalidate for an unsuccessful work if there is no title" do
    is_valid = movie2.valid?
    
    refute( is_valid )
  end

  it "user adds new work correctly, should be successful" do
    
  end

  it "user adds new work incorrectly, should be unsuccessful" do
    
  end
  
end
