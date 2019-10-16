require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe "validations" do
    it "correctly validates a work with a unique title" do
    end
    
    it "invalidates a work with no title" do
    end
    
    it "invalidates a work whose title is not unique within the scope of the category" do
    end
  end
  
  describe "custom methods" do
    it "can get the top ten works by vote" do
    end
    
    it "retrieves fewer than ten works if fewer than ten are in the category" do
    end
  end
  
end
